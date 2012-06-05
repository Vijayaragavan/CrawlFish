class CreateTriggerInsertUpdateDeleteOnAdvertiserTransactions < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS monetization.t_insert_advertiser_transactions"

    execute <<-SQL
    CREATE TRIGGER monetization.t_insert_advertiser_transactions AFTER INSERT ON monetization.advertiser_transactions
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_insert_advertiser_transactions';
    DECLARE v_subscribed_date, v_cut_off_date DATE;
    DECLARE v_ad_list_id INT;
    DECLARE v_amount DOUBLE;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

    SELECT cut_off_date INTO v_cut_off_date FROM monetization.advertiser_financials
    WHERE advertiser_financial_id = new.advertiser_financial_id;

    IF new.transaction_date <= v_cut_off_date THEN

    SET v_subscribed_date = v_cut_off_date + INTERVAL 1 DAY;

    ELSE

    SET v_subscribed_date = new.transaction_date + INTERVAL 1 DAY;

    END IF;

    UPDATE monetization.advertiser_financials SET paid_flag = 1, updated_at = CURRENT_TIMESTAMP 
    WHERE advertiser_financial_id = new.advertiser_financial_id;

    IF new.history_flag = 0 THEN

    SELECT MAX(ad_list_id) INTO v_ad_list_id FROM monetization.advertiser_financials;

    SELECT amount INTO v_amount FROM monetization.advertiser_financials
    WHERE advertiser_financial_id = new.advertiser_financial_id;

    INSERT INTO monetization.advertiser_financials(advertiser_id, ad_list_id, subscribed_date, notification_date, cut_off_date, amount, created_at)
    VALUES(new.advertiser_id, (v_ad_list_id+1), v_subscribed_date, (v_subscribed_date + INTERVAL 20 DAY), 
    (v_subscribed_date + INTERVAL 1 MONTH), v_amount, CURRENT_TIMESTAMP);

    END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TRIGGER monetization.t_insert_advertiser_transactions"
  end
end

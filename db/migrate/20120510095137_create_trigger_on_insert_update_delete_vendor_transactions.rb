class CreateTriggerOnInsertUpdateDeleteVendorTransactions < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS monetization.t_insert_vendor_transactions"

    execute <<-SQL
    CREATE TRIGGER monetization.t_insert_vendor_transactions AFTER INSERT ON monetization.vendor_transactions
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_insert_vendor_transactions';
    DECLARE v_monetization_id, v_fixed_pay_id, v_cut_off_period_id INT;
    DECLARE v_monetization_type VARCHAR(255);
    DECLARE v_subscribed_date, v_cut_off_date DATE;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

    SELECT cut_off_date INTO v_cut_off_date FROM monetization.vendor_financials
    WHERE vendor_financial_id = new.vendor_financial_id;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat("Cut_off_date is ",v_cut_off_date));

    IF new.transaction_date <= v_cut_off_date THEN

    SET v_subscribed_date = v_cut_off_date + INTERVAL 1 DAY;

    ELSE

    SET v_subscribed_date = new.transaction_date + INTERVAL 1 DAY;

    END IF;

    UPDATE monetization.vendor_financials SET paid_flag = 1, updated_at = CURRENT_TIMESTAMP 
    WHERE vendor_financial_id = new.vendor_financial_id;

    SELECT monetization_id, monetization_type INTO v_monetization_id, v_monetization_type FROM monetization.vendor_financials
    WHERE vendor_financial_id = new.vendor_financial_id;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat("Monetization type is ",v_monetization_type," and monetization id is ",v_monetization_id));

    IF v_monetization_type = "variable" OR v_monetization_type = "purchase" THEN

    UPDATE monetization.variable_pays SET paid_flag = 1, updated_at = CURRENT_TIMESTAMP 
    WHERE variable_pay_id = v_monetization_id;

    ELSEIF v_monetization_type = "fixed" AND v_monetization_id > 0 THEN

    SELECT fixed_pay_id, cut_off_period_id INTO v_fixed_pay_id, v_cut_off_period_id FROM monetization.vendors_fixed_pays
    WHERE vendor_id = new.vendor_id AND v_fp_id = v_monetization_id;

    UPDATE monetization.vendors_fixed_pays SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
    WHERE vendor_id = new.vendor_id AND v_fp_id = v_monetization_id;

    INSERT INTO monetization.vendors_fixed_pays(vendor_id, fixed_pay_id, cut_off_period_id, subscribed_date, created_at)
    VALUES(new.vendor_id, v_fixed_pay_id, v_cut_off_period_id, v_subscribed_date, CURRENT_TIMESTAMP);

    END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TRIGGER monetization.t_insert_vendor_transactions"
  end
end

class CreateTriggerInsertUpdateDeleteAdsLists < ActiveRecord::Migration
  def up

    execute <<-SQL
    CREATE TRIGGER t_Insert_ad_lists AFTER INSERT ON ad_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_amount DOUBLE;
    DECLARE v_notification_date, v_cut_off_date DATE;

    SELECT banner_cost INTO v_amount FROM ad_banners
    WHERE banner_height = new.banner_height AND banner_width = new.banner_width AND duration = new.duration;

	SET v_notification_date = new.subscribed_date + INTERVAL 20 DAY;
	SET v_cut_off_date = new.subscribed_date + INTERVAL 1 MONTH;

    IF new.banner_height > 0 AND new.banner_width > 0 AND new.duration > 0 THEN

    INSERT INTO monetization.advertiser_financials(advertiser_id,ad_list_id,subscribed_date,notification_date,cut_off_date,amount,created_at)
    VALUES(new.advertiser_id,new.ad_list_id,new.subscribed_date,v_notification_date,v_cut_off_date,v_amount,CURRENT_TIMESTAMP);

    END IF;

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_ad_lists AFTER UPDATE ON ad_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_amount DOUBLE;
    DECLARE v_notification_date, v_cut_off_date DATE;
    DECLARE v_count INT;

    IF new.banner_height > 0 AND new.banner_width > 0 AND new.duration > 0 THEN

    SELECT banner_cost INTO v_amount FROM ad_banners
    WHERE banner_height = new.banner_height AND banner_width = new.banner_width AND duration = new.duration;

	SET v_notification_date = new.subscribed_date + INTERVAL 20 DAY;
	SET v_cut_off_date = new.subscribed_date + INTERVAL 1 MONTH;

    SELECT COUNT(*) INTO v_count FROM monetization.advertiser_financials
    WHERE advertiser_id = old.advertiser_id AND ad_list_id = new.ad_list_id AND history_flag = 0;

    IF v_count = 0 THEN

    INSERT INTO monetization.advertiser_financials(advertiser_id,ad_list_id,subscribed_date,notification_date,cut_off_date,amount,created_at)
    VALUES(new.advertiser_id,new.ad_list_id,new.subscribed_date,v_notification_date,v_cut_off_date,v_amount,CURRENT_TIMESTAMP); 

    ELSE

    UPDATE monetization.advertiser_financials SET subscribed_date = new.subscribed_date,
						  notification_date = v_notification_date,
						  cut_off_date = v_cut_off_date,
						  amount = v_amount,
						  updated_at = CURRENT_TIMESTAMP
    WHERE ad_list_id = new.ad_list_id AND history_flag = 0;

    END IF;

    END IF;

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_ad_lists AFTER DELETE ON ad_lists
    FOR EACH ROW
    BEGIN

	UPDATE monetization.advertiser_financials SET history_flag = 1,
						      updated_at = CURRENT_TIMESTAMP
    	WHERE ad_list_id = old.ad_list_id AND history_flag = 0;

	UPDATE monetization.advertiser_transactions SET history_flag = 1,
						      updated_at = CURRENT_TIMESTAMP
    	WHERE advertiser_id = old.advertiser_id AND history_flag = 0;

    END
    SQL

  end

  def down
    execute "DROP TRIGGER t_Insert_ad_lists"
    execute "DROP TRIGGER t_Update_ad_lists"
    execute "DROP TRIGGER t_Delete_ad_lists"
  end
end

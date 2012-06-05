class CreateProcedureToInsertUpdateDeleteVendorFinancials < ActiveRecord::Migration
  def up

	execute "DROP PROCEDURE IF EXISTS p_Insert_update_delete_vendor_financials"

	execute <<-SQL

	CREATE PROCEDURE p_Insert_update_delete_vendor_financials()

	BEGIN

	DECLARE loopcounter INT DEFAULT 1;
	DECLARE v_fp_vendors_count, v_count, v_vendor_id, v_fixed_pay_id, v_cut_off_period_id, v_cut_off_period, v_subscription_period, v_date_diff,
	v1_variable_pay_count, v1_vendor_id, v1_vp_count, v1_pp_count, v1_count, v1_cut_off_period_id, v2_blocked_flag, v2_discarded_flag,
	v1_history_flag, v1_cut_off_period, v1_cut_off_amount_id, v2_vendor_id, v_financial_count, v3_vendor_id, 
	v_advertiser_financial_count, v2_paid_flag, v_advertiser_id, v_a_paid_flag, v_a_blocked_flag, v_a_discarded_flag INT;
	DECLARE v_subscription_cost, v1_amount DOUBLE;
	DECLARE v_subscribed_date, v_date_end, v_current_date, v_notification_date, v_cut_off_date, v1_notification_date, 
	v1_cut_off_date, v1_subscribed_date, v2_cut_off_date, v_a_cut_off_date DATE;
	DECLARE v_DebugID VARCHAR(255) DEFAULT 'p_Insert_update_delete_vendor_financials';
	DECLARE v1_monetization_type VARCHAR(255);

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);


	SELECT MAX(v_fp_id) INTO v_fp_vendors_count FROM monetization.vendors_fixed_pays;

	carrier_loop: LOOP
	 IF loopcounter <= v_fp_vendors_count THEN
	
		SELECT vendor_id,fixed_pay_id,cut_off_period_id,subscribed_date INTO v_vendor_id,v_fixed_pay_id,v_cut_off_period_id,v_subscribed_date
		FROM monetization.vendors_fixed_pays
		WHERE history_flag = 0 AND v_fp_id = loopcounter;


		IF v_fixed_pay_id IS NOT NULL THEN

			SELECT COUNT(*) INTO v_count FROM monetization.vendor_financials
			WHERE vendor_id = v_vendor_id AND history_flag = 0 AND monetization_type = "fixed" AND subscription_date = v_subscribed_date;

			IF v_count = 0 THEN
			
			SELECT subscription_cost, subscription_period INTO v_subscription_cost, v_subscription_period FROM monetization.fixed_pays
			WHERE fixed_pay_id = v_fixed_pay_id;

			SELECT cut_off_period INTO v_cut_off_period FROM monetization.cut_off_periods
			WHERE cut_off_period_id = v_cut_off_period_id;


			SET v_date_diff = DATEDIFF(CURRENT_TIMESTAMP,v_subscribed_date);

			SET v_date_end = v_subscribed_date + INTERVAL v_subscription_period MONTH;

			IF DATEDIFF(v_date_end,CURRENT_TIMESTAMP) <= v_cut_off_period THEN

				SET v_notification_date = CURRENT_TIMESTAMP;

				SET v_cut_off_date = v_date_end;
	

				INSERT INTO monetization.vendor_financials(vendor_id,monetization_id,monetization_type,subscription_date,
				notification_date,cut_off_date,amount,created_at)
				VALUES(v_vendor_id,loopcounter,"fixed",v_subscribed_date,v_notification_date,v_cut_off_date,v_subscription_cost,CURRENT_TIMESTAMP);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Record inserted into vendor_financials table for vendor ',v_vendor_id));

			END IF;

			ELSE

			SELECT subscription_cost, subscription_period INTO v_subscription_cost, v_subscription_period FROM monetization.fixed_pays
			WHERE fixed_pay_id = v_fixed_pay_id;

			UPDATE monetization.vendor_financials SET amount = v_subscription_cost, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v_vendor_id AND history_flag = 0 AND subscription_date = v_subscribed_date;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Record updated in vendor_financials table for vendor ',v_vendor_id));

			END IF;

		ELSE

		SELECT vendor_id INTO v_vendor_id FROM monetization.vendors_fixed_pays
		WHERE v_fp_id = loopcounter;

		SELECT COUNT(*) INTO v_count FROM monetization.vendor_financials
		WHERE vendor_id = v_vendor_id AND history_flag = 0 AND monetization_type = "fixed";

		IF v_count = 1 THEN
		
			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v_vendor_id AND history_flag = 0 AND monetization_type = "fixed";

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Record made history in vendor_financials table for vendor ',v_vendor_id));

		END IF;

		END IF;
	 
	 ELSE
		LEAVE carrier_loop;
	 END IF;
	SET loopcounter = loopcounter + 1;
	END LOOP carrier_loop;

	SET loopcounter = 1;

	

	SELECT MAX(variable_pay_id) INTO v1_variable_pay_count FROM monetization.variable_pays;

	carrier_loop: LOOP
	 IF loopcounter <= v1_variable_pay_count THEN

		SELECT vendor_id,total_amount INTO v1_vendor_id,v1_amount FROM monetization.variable_pays
		WHERE financial_flag = 0 AND variable_pay_id = loopcounter;

		IF v1_vendor_id IS NOT NULL THEN

			SELECT DISTINCT subscribed_date INTO v1_subscribed_date FROM product_purchase_commission_vendors
			WHERE vendor_id = v1_vendor_id;

			SELECT DISTINCT cut_off_period_id INTO v1_cut_off_period_id FROM monetization.vendors_product_purchase_commissions
			WHERE vendor_id = v1_vendor_id;

			SELECT cut_off_period INTO v1_cut_off_period FROM monetization.cut_off_periods
			WHERE cut_off_period_id = v1_cut_off_period_id;

			SELECT COUNT(*) INTO v1_vp_count FROM monetization.vendors_variable_pays
			WHERE vendor_id = v1_vendor_id;

			SELECT COUNT(*) INTO v1_pp_count FROM monetization.vendors_product_purchase_commissions
			WHERE vendor_id = v1_vendor_id;

			IF v1_vp_count > 0 AND v1_pp_count > 0 THEN

				SET v1_monetization_type = "variable";

			ELSEIF v1_pp_count > 0 THEN
			
				SET v1_monetization_type = "purchase";

			END IF;

			SET v1_notification_date = CURRENT_TIMESTAMP;
			SET v1_cut_off_date = v1_notification_date + INTERVAL v1_cut_off_period DAY;

			INSERT INTO monetization.vendor_financials(vendor_id,monetization_id,monetization_type,subscription_date,
			notification_date,cut_off_date,amount,created_at)
			VALUES(v1_vendor_id,loopcounter,v1_monetization_type,v1_subscribed_date,v1_notification_date,
			v1_cut_off_date,v1_amount,CURRENT_TIMESTAMP);

			UPDATE monetization.variable_pays SET financial_flag = 1,updated_at = CURRENT_TIMESTAMP
			WHERE variable_pay_id = loopcounter;


		END IF;

		SELECT vendor_id INTO v2_vendor_id FROM monetization.variable_pays
		WHERE history_flag = 1 AND variable_pay_id = loopcounter;

		SELECT COUNT(*) INTO v1_vp_count FROM monetization.vendors_variable_pays
		WHERE vendor_id = v2_vendor_id AND history_flag = 1;

		SELECT COUNT(*) INTO v1_pp_count FROM monetization.vendors_product_purchase_commissions
		WHERE vendor_id = v2_vendor_id AND history_flag = 1;

	    /* Insert a record in debug table for tracking the events */
   	    call debug.debug_insert(v_DebugID,concat('Vendor id is ',v2_vendor_id));
   	    call debug.debug_insert(v_DebugID,concat('Product purchase count id is ',v1_pp_count));

		IF v2_vendor_id > 0 AND v1_vp_count > 0 THEN

			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v2_vendor_id AND history_flag = 0 AND monetization_type = "variable";

		ELSEIF v2_vendor_id > 0 AND v1_pp_count > 0 THEN

	    /* Insert a record in debug table for tracking the events */
   	    call debug.debug_insert(v_DebugID,'Entered ELSEIF block');

			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v2_vendor_id AND history_flag = 0 AND monetization_type = "purchase";

		END IF;

	 ELSE
		LEAVE carrier_loop;
	 END IF;
	SET loopcounter = loopcounter + 1;
	END LOOP carrier_loop;

	SET loopcounter = 1;


	
	SELECT MAX(vendor_financial_id) INTO v_financial_count FROM monetization.vendor_financials;

	carrier_loop: LOOP
	 IF loopcounter <= v_financial_count THEN

		SELECT vendor_id, cut_off_date, paid_flag  INTO v3_vendor_id, v2_cut_off_date, v2_paid_flag FROM monetization.vendor_financials
		WHERE vendor_financial_id = loopcounter;

		SELECT blocked_flag, discarded_flag INTO v2_blocked_flag, v2_discarded_flag FROM vendors_lists
		WHERE vendor_id = v3_vendor_id;

		IF CURRENT_TIMESTAMP > v2_cut_off_date AND v2_paid_flag = 0 AND v2_blocked_flag = 0 THEN

		UPDATE vendors_lists SET blocked_flag = 1, updated_at = CURRENT_TIMESTAMP
		WHERE vendor_id = v3_vendor_id;

		ELSEIF DATEDIFF(CURRENT_TIMESTAMP,v2_cut_off_date) > 30 AND v2_paid_flag = 0 AND v2_discarded_flag = 0 THEN
		
		UPDATE vendors_lists SET discarded_flag = 1, updated_at = CURRENT_TIMESTAMP
		WHERE vendor_id = v3_vendor_id;

		END IF;

	 ELSE
		LEAVE carrier_loop;
	 END IF;
	SET loopcounter = loopcounter + 1;
	END LOOP carrier_loop;

	SET loopcounter = 1;



	SELECT MAX(advertiser_financial_id) INTO v_advertiser_financial_count FROM monetization.advertiser_financials;

	carrier_loop: LOOP
	 IF loopcounter <= v_advertiser_financial_count THEN

		SELECT advertiser_id, cut_off_date, paid_flag  INTO v_advertiser_id, v_a_cut_off_date, v_a_paid_flag FROM monetization.advertiser_financials
		WHERE advertiser_financial_id = loopcounter;

		SELECT blocked_flag, discarded_flag INTO v_a_blocked_flag, v_a_discarded_flag FROM advertisers_lists
		WHERE advertiser_id = v_advertiser_id;

		IF CURRENT_TIMESTAMP > v_a_cut_off_date AND v_a_paid_flag = 0 AND v_a_blocked_flag = 0 THEN

		UPDATE advertisers_lists SET blocked_flag = 1, updated_at = CURRENT_TIMESTAMP
		WHERE advertiser_id = v_advertiser_id;

		ELSEIF DATEDIFF(CURRENT_TIMESTAMP,v_a_cut_off_date) > 30 AND v_a_paid_flag = 0 AND v_a_discarded_flag = 0 THEN
		
		UPDATE advertisers_lists SET discarded_flag = 1, updated_at = CURRENT_TIMESTAMP
		WHERE advertiser_id = v_advertiser_id;

		END IF;

	 ELSE
		LEAVE carrier_loop;
	 END IF;
	SET loopcounter = loopcounter + 1;
	END LOOP carrier_loop;

	SET loopcounter = 1;	
	

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

	END
	SQL
  end

  def down
	execute "DROP PROCEDURE p_Insert_update_delete_vendor_financials"
  end
end

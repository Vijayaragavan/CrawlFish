class CreateProcedureToInsertUpdateDeleteVendorPaysTable < ActiveRecord::Migration
  def up
	execute "DROP PROCEDURE IF EXISTS p_Insert_update_delete_vendor_pays"
	execute <<-SQL

	CREATE PROCEDURE p_Insert_update_delete_vendor_pays( IN v1_DebugID VARCHAR(255), 
	       						     IN v1_pay_type VARCHAR(255), 
					                     IN v1_vendor_id INT,
							     IN v1_sub_category_id INT,
	       						     IN v1_fp_amount DOUBLE,
	       						     IN v1_vp_i_rate DOUBLE,
	       						     IN v1_vp_bc_rate DOUBLE,
							     IN v1_pp_comm INT,
							     IN v1_subscribed_date DATE,
							     IN v1_cut_off_period INT,
							     IN v1_cut_off_amount INT,
							     IN v1_history_flag INT)

	BEGIN

	DECLARE v_fixed_pay_id, v_cut_off_period_id, v_cut_off_amount_id, v_i_rate_id, v_bc_rate_id, v_pp_commission_id,
 		v_fp_count, v_vp_count, v_ppc_count, v_v_fp_id INT;


	IF v1_pay_type = "fixed" AND v1_history_flag = 0 THEN

		IF v1_fp_amount > 0 THEN
			SELECT fixed_pay_id INTO v_fixed_pay_id FROM monetization.fixed_pays
			WHERE subscription_cost = v1_fp_amount;
		END IF;

		IF v1_cut_off_period > 0 THEN
			SELECT cut_off_period_id INTO v_cut_off_period_id FROM monetization.cut_off_periods
			WHERE cut_off_period = v1_cut_off_period;
		END IF;
		
		SELECT COUNT(*) INTO v_fp_count FROM monetization.vendors_fixed_pays
		WHERE vendor_id = v1_vendor_id;
				
		IF v_fp_count = 0 AND v_fixed_pay_id > 0 AND v_cut_off_period_id > 0 AND v1_subscribed_date > 0 THEN
				
			INSERT INTO monetization.vendors_fixed_pays(vendor_id,fixed_pay_id,cut_off_period_id,
			subscribed_date,created_at)
			VALUES(v1_vendor_id,v_fixed_pay_id,v_cut_off_period_id,v1_subscribed_date,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Inserted a record into vendors_fixed_pays table for vendor_id ',v1_vendor_id));



		ELSEIF v_fp_count = 1 AND v_fixed_pay_id > 0 AND v_cut_off_period_id > 0 AND v1_subscribed_date > 0 THEN
			
			UPDATE monetization.vendors_fixed_pays SET fixed_pay_id = v_fixed_pay_id,
							   cut_off_period_id = v_cut_off_period_id,
							   subscribed_date = v1_subscribed_date,
							   history_flag = 0,
							   updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Updated the record in vendors_fixed_pays table for vendor_id ',v1_vendor_id));


		END IF;

	ELSEIF v1_pay_type = "fixed" AND v1_history_flag = 1 THEN
			
			UPDATE monetization.vendors_fixed_pays SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_transactions SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

		/* Insert a record in debug table for tracking the events */
    		call debug.debug_insert(v1_DebugID,concat('History flag set for the records in vendors_fixed_pays, vendor_financials and vendor_transactions table for vendor_id ',v1_vendor_id));

	END IF;

	IF v1_pay_type = "variable" AND v1_history_flag = 0 THEN

		IF v1_vp_i_rate != 0 THEN
			SELECT i_rate_id INTO v_i_rate_id FROM monetization.impression_rates
			WHERE impression_rates = v1_vp_i_rate;
		END IF;

		IF v1_vp_bc_rate != 0 THEN
			SELECT bc_rate_id INTO v_bc_rate_id FROM monetization.button_click_rates
			WHERE button_click_rates = v1_vp_bc_rate;
		END IF;

		IF v1_cut_off_period > 0 THEN
			SELECT cut_off_period_id INTO v_cut_off_period_id FROM monetization.cut_off_periods
			WHERE cut_off_period = v1_cut_off_period;
		END IF;

		IF v1_cut_off_amount > 0 THEN
			SELECT cut_off_amount_id INTO v_cut_off_amount_id FROM monetization.cut_off_amounts
			WHERE cut_off_amount = v1_cut_off_amount;
		END IF;
		
		SELECT COUNT(*) INTO v_vp_count FROM monetization.vendors_variable_pays
		WHERE vendor_id = v1_vendor_id;

		
		IF v_vp_count = 0 AND v_i_rate_id > 0 AND v_bc_rate_id > 0 AND v_cut_off_period_id > 0 AND
		v_cut_off_amount_id > 0 THEN
				
			INSERT INTO monetization.vendors_variable_pays(vendor_id,i_rate_id,bc_rate_id,cut_off_period_id,
			cut_off_amount_id,created_at)
			VALUES(v1_vendor_id,v_i_rate_id,v_bc_rate_id,v_cut_off_period_id,v_cut_off_amount_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Inserted a record into vendors_variable_pays table for vendor_id ',v1_vendor_id));

		ELSEIF v_vp_count = 1 AND v_i_rate_id > 0 AND v_bc_rate_id > 0 AND v_cut_off_period_id > 0 AND
		v_cut_off_amount_id > 0 THEN
			
			UPDATE monetization.vendors_variable_pays SET i_rate_id = v_i_rate_id,
								   bc_rate_id = v_bc_rate_id,
								   cut_off_period_id = v_cut_off_period_id,
								   cut_off_amount_id = v_cut_off_amount_id,
								   history_flag = 0,
								   updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Updated the record in vendors_variable_pays table for vendor_id ',v1_vendor_id));

		END IF;

	ELSEIF v1_pay_type = "variable" AND v1_history_flag = 1 THEN

			UPDATE monetization.vendors_variable_pays SET history_flag = 1,
								   updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

		/* Insert a record in debug table for tracking the events */
    		call debug.debug_insert(v1_DebugID,concat('History flag set for the record in vendors_variable_pays table for vendor_id ',v1_vendor_id));

			UPDATE monetization.variable_pays SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_transactions SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

		/* Insert a record in debug table for tracking the events */
    		call debug.debug_insert(v1_DebugID,concat('History flag set for the records in variable_pays, vendor_financials and vendor_transaction table for vendor_id ',v1_vendor_id));


	END IF;


	IF v1_pay_type = "purchase" AND v1_history_flag = 0 THEN

		IF v1_pp_comm != 0 THEN
			SELECT pp_commission_id INTO v_pp_commission_id FROM monetization.product_purchase_commissions
			WHERE product_purchase_commissions = v1_pp_comm;
		END IF;

		IF v1_cut_off_period > 0 THEN
			SELECT cut_off_period_id INTO v_cut_off_period_id FROM monetization.cut_off_periods
			WHERE cut_off_period = v1_cut_off_period;
		END IF;

		IF v1_cut_off_amount > 0 THEN
			SELECT cut_off_amount_id INTO v_cut_off_amount_id FROM monetization.cut_off_amounts
			WHERE cut_off_amount = v1_cut_off_amount;
		END IF;
		
		SELECT COUNT(*) INTO v_ppc_count FROM monetization.vendors_product_purchase_commissions
		WHERE vendor_id = v1_vendor_id AND sub_category_id = v1_sub_category_id;

			
		IF v_ppc_count = 0 AND v_pp_commission_id > 0 AND v_cut_off_period_id > 0 AND v_cut_off_amount_id > 0 THEN
				
			INSERT INTO monetization.vendors_product_purchase_commissions(vendor_id,sub_category_id,commission_id,cut_off_period_id,
			cut_off_amount_id,created_at)
			VALUES(v1_vendor_id,v1_sub_category_id,v_pp_commission_id,v_cut_off_period_id,v_cut_off_amount_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Inserted a record into vendors_product_purchase_commissions table for vendor_id ', 				v1_vendor_id));

		ELSEIF v_ppc_count = 1 AND v_pp_commission_id > 0 AND v_cut_off_period_id > 0 AND v_cut_off_amount_id > 0 THEN
			
			UPDATE monetization.vendors_product_purchase_commissions SET commission_id = v_pp_commission_id,
								   			cut_off_period_id = v_cut_off_period_id,
								   			cut_off_amount_id = v_cut_off_amount_id,
											history_flag = 0,
								   			updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id AND sub_category_id = v1_sub_category_id;

			/* Insert a record in debug table for tracking the events */
    			call debug.debug_insert(v1_DebugID,concat('Updated the record in vendors_product_purchase_commissions table for vendor_id ',v1_vendor_id));

		END IF;

	ELSEIF v1_pay_type = "purchase" AND v1_history_flag = 1 THEN

			UPDATE monetization.vendors_product_purchase_commissions SET history_flag = 1,
								   			updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id AND sub_category_id = v1_sub_category_id;

		/* Insert a record in debug table for tracking the events */
    		call debug.debug_insert(v1_DebugID,concat('History flag set for the record in vendors_product_purchase_commissions table for vendor_id' 
		,v1_vendor_id));

			UPDATE monetization.variable_pays SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_financials SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

			UPDATE monetization.vendor_transactions SET history_flag = 1, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id;

		/* Insert a record in debug table for tracking the events */
    		call debug.debug_insert(v1_DebugID,concat('History flag set for the records in variable_pays, vendor_financials and vendor_transaction table for vendor_id ',v1_vendor_id));

	END IF;


	END
	SQL
  end

  def down
	execute "DROP PROCEDURE p_Insert_update_delete_vendor_pays"
  end
end

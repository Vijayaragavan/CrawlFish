class CreateProcedureToInsertUpdateDeleteCumulativeVariablePays < ActiveRecord::Migration
  def up
	execute "DROP PROCEDURE IF EXISTS p_Insert_update_delete_cumulative_variable_pays"
	execute <<-SQL

	CREATE PROCEDURE p_Insert_update_delete_cumulative_variable_pays( IN v1_vendor_id INT, 
									IN v1_sub_category_id INT,
									IN v1_product_id INT,
									IN v1_total_amount DOUBLE,
									IN v1_log_date DATE,
									IN v1_DebugID VARCHAR(255))

	BEGIN

		DECLARE v_count, v_vendor_count, v_cut_off_amount_id, v_variable_pay_id INT;
		DECLARE v_cut_off_amount, v_old_amount, v_final_amount DOUBLE;

		SELECT COUNT(*) INTO v_count FROM monetization.cumulative_variable_pays
		WHERE vendor_id = v1_vendor_id AND sub_category_id = v1_sub_category_id AND product_id = v1_product_id AND history_flag = 0;

		SELECT COUNT(*) INTO v_vendor_count FROM monetization.vendors_variable_pays
		WHERE vendor_id = v1_vendor_id AND history_flag = 0;
		
		IF v_vendor_count = 0 THEN
		
			SELECT DISTINCT cut_off_amount_id INTO v_cut_off_amount_id FROM monetization.vendors_product_purchase_commissions
			WHERE vendor_id = v1_vendor_id;

			SELECT cut_off_amount INTO v_cut_off_amount FROM monetization.cut_off_amounts
			WHERE cut_off_amount_id = v_cut_off_amount_id;

		/* Insert a record in debug table for tracking the events */
		call debug.debug_insert(v1_DebugID,concat('cut_off_amount is ',v_cut_off_amount));

		ELSE
		
			SELECT cut_off_amount_id INTO v_cut_off_amount_id FROM monetization.vendors_variable_pays
			WHERE vendor_id = v1_vendor_id;

			SELECT cut_off_amount INTO v_cut_off_amount FROM monetization.cut_off_amounts
			WHERE cut_off_amount_id = v_cut_off_amount_id;

		/* Insert a record in debug table for tracking the events */
		call debug.debug_insert(v1_DebugID,concat('cut_off_amount is ',v_cut_off_amount));

		END IF;

		IF v_count = 0 THEN

		INSERT INTO monetization.cumulative_variable_pays(vendor_id,sub_category_id,product_id,total_amount,log_date,created_at)
		VALUES(v1_vendor_id,v1_sub_category_id,v1_product_id,v1_total_amount,v1_log_date,CURRENT_TIMESTAMP);

		/* Insert a record in debug table for tracking the events */
		call debug.debug_insert(v1_DebugID,concat('Inserted a record into cumulative_variable_pays table for the vendor_id ',v1_vendor_id, 
		' sub_category_id ',v1_sub_category_id,' product_id ',v1_product_id));

		ELSEIF v_count = 1 THEN

		UPDATE monetization.cumulative_variable_pays SET total_amount = v1_total_amount, updated_at = CURRENT_TIMESTAMP
		WHERE vendor_id = v1_vendor_id AND sub_category_id = v1_sub_category_id AND product_id = v1_product_id AND history_flag = 0;

		/* Insert a record in debug table for tracking the events */
		call debug.debug_insert(v1_DebugID,concat('Updated the amount in cumulative_variable_pays table for the vendor_id ',v1_vendor_id, 
		' sub_category_id ',v1_sub_category_id,' product_id ',v1_product_id));

		END IF;
	
		SELECT SUM(total_amount) INTO v_final_amount FROM monetization.cumulative_variable_pays
		WHERE vendor_id = v1_vendor_id AND history_flag = 0;

		IF v_final_amount >= v_cut_off_amount THEN

			INSERT INTO monetization.variable_pays(vendor_id,total_amount,created_at)
			VALUES(v1_vendor_id,v_final_amount,CURRENT_TIMESTAMP);
	
			SELECT MAX(variable_pay_id) INTO v_variable_pay_id FROM monetization.variable_pays;

			/* Insert a record in debug table for tracking the events */
			call debug.debug_insert(v1_DebugID,concat('Inserted a record into variable_pays table for the vendor_id ',v1_vendor_id));

			UPDATE monetization.cumulative_variable_pays SET history_flag = 1, variable_pay_id = v_variable_pay_id, updated_at = CURRENT_TIMESTAMP
			WHERE vendor_id = v1_vendor_id AND history_flag = 0;

		END IF;

	
	END
	SQL
  end

  def down
	execute "DROP PROCEDURE p_Insert_update_delete_cumulative_variable_pays"
  end
end

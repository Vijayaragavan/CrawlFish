class CreateProcedureInsertIntoTransactionsLog < ActiveRecord::Migration
  def up
	execute "DROP PROCEDURE IF EXISTS p_Insert_transaction_logs"
	execute <<-SQL

	CREATE PROCEDURE p_Insert_transaction_logs ( IN v1_DebugID VARCHAR(255), 
						       IN v1_unique_id INT,
						       IN v1_type VARCHAR(255),
					 	       IN v1_log_date DATE)

	BEGIN
	
		DECLARE v_vendor_id, v_products_list_id, v_sub_category_id VARCHAR(255);
		DECLARE v_count, v_log_id, v_p_i_count, v_b_c_count INT;

		/* Collecting the information from link_products_lists_vendors table */
		call debug.debug_insert(v1_DebugID,'Entered into procedure');

		SELECT vendor_id,products_list_id,sub_category_id INTO v_vendor_id,v_products_list_id,v_sub_category_id
		FROM link_products_lists_vendors WHERE unique_id = v1_unique_id;

		/* Collecting the information from link_products_lists_vendors table */
		call debug.debug_insert(v1_DebugID,concat('Information collected for the unique id ',v1_unique_id));

		SELECT COUNT(*) INTO v_count FROM vendor_product_transactions_logs
		WHERE vendor_id = v_vendor_id AND sub_category_id = v_sub_category_id
		AND product_id = v_products_list_id AND log_date = v1_log_date;

		IF v_count = 1 THEN

		SELECT v_p_trans_log_id, page_impressions_count, button_clicks_count INTO v_log_id, v_p_i_count, v_b_c_count
		FROM vendor_product_transactions_logs
		WHERE vendor_id = v_vendor_id AND sub_category_id = v_sub_category_id
		AND product_id = v_products_list_id AND log_date = v1_log_date;

			IF v1_type = "clicks" THEN

			SET v_b_c_count = v_b_c_count + 1;

			UPDATE vendor_product_transactions_logs SET button_clicks_count = v_b_c_count, updated_at = CURRENT_TIMESTAMP
			WHERE v_p_trans_log_id = v_log_id;

			/* Calling the procedure debug.debug_insert */
			call debug.debug_insert(v1_DebugID,concat('Button click count updated in vendor_product_transactions_log table for the unique id ',v1_unique_id));


			ELSEIF v1_type = "impressions" THEN

			SET v_p_i_count = v_p_i_count + 1;

			UPDATE vendor_product_transactions_logs SET page_impressions_count = v_p_i_count, updated_at = CURRENT_TIMESTAMP
			WHERE v_p_trans_log_id = v_log_id;

			/* Calling the procedure debug.debug_insert */
			call debug.debug_insert(v1_DebugID,concat('Impression count updated in vendor_product_transactions_log table for the unique id ',v1_unique_id));	

			END IF;

		ELSEIF v_count = 0 THEN

			IF v1_type = "clicks" THEN	

			INSERT INTO vendor_product_transactions_logs(vendor_id, sub_category_id, product_id, button_clicks_count, log_date, created_at)
			VALUES(v_vendor_id, v_sub_category_id, v_products_list_id, 1, v1_log_date, CURRENT_TIMESTAMP);

			/* Calling the procedure debug.debug_insert */
			call debug.debug_insert(v1_DebugID,concat('Record inserted into vendor_product_transactions_log table for the unique id ',v1_unique_id));

			ELSEIF v1_type = "impressions" THEN	

			INSERT INTO vendor_product_transactions_logs(vendor_id, sub_category_id, product_id, page_impressions_count, log_date, created_at)
			VALUES(v_vendor_id, v_sub_category_id, v_products_list_id, 1, v1_log_date, CURRENT_TIMESTAMP);

			/* Calling the procedure debug.debug_insert */
			call debug.debug_insert(v1_DebugID,concat('Record inserted into vendor_product_transactions_log table for the unique id ',v1_unique_id));

			END IF;

		END IF;
	END
	SQL
  end

  def down
	execute "DROP PROCEDURE p_Insert_transaction_logs"
  end
end

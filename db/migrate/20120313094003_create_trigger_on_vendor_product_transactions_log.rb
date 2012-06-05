class CreateTriggerOnVendorProductTransactionsLog < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_insert_vendor_product_transactions_logs"
    execute "DROP TRIGGER IF EXISTS t_update_vendor_product_transactions_logs"

    execute <<-SQL
    CREATE TRIGGER t_insert_vendor_product_transactions_logs AFTER INSERT ON vendor_product_transactions_logs
    FOR EACH ROW
    BEGIN

	DECLARE v_i_rate_id, v_bc_rate_id, v_count INT;
	DECLARE v_impression_rates, v_button_click_rates, v_page_imp_amount, v_t_i_amount, v_t_bc_amount, v_button_click_amount, v_total_amount DOUBLE;
	DECLARE v_DebugID VARCHAR(255) DEFAULT 't_insert_vendor_product_transactions_logs';

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	SELECT COUNT(*) INTO v_count FROM variable_pay_vendors
	WHERE vendor_id = new.vendor_id AND history_flag = 0;

	IF v_count > 0 THEN

	IF new.vendor_id > 0 AND new.sub_category_id > 0 AND new.product_id > 0 THEN

	SELECT i_rate_id,bc_rate_id INTO v_i_rate_id,v_bc_rate_id FROM monetization.vendors_variable_pays
	WHERE vendor_id = new.vendor_id;

	SELECT impression_rates INTO v_impression_rates FROM monetization.impression_rates
	WHERE i_rate_id = v_i_rate_id;

	SELECT button_click_rates INTO v_button_click_rates FROM monetization.button_click_rates
	WHERE bc_rate_id = v_bc_rate_id;

	SET v_page_imp_amount = (new.page_impressions_count * v_impression_rates);
	SET v_button_click_amount = (new.button_clicks_count * v_button_click_rates);

	IF v_page_imp_amount IS NULL THEN

	SET v_page_imp_amount = 0;

	END IF;

	IF v_button_click_amount IS NULL THEN

	SET v_button_click_amount = 0;
	
	END IF;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Variable pay amounts are calculated successfully');

	INSERT INTO monetization.variable_pay_logs(vendor_id,sub_category_id,product_id,total_impressions_amount,total_button_clicks_amount,
	log_date,created_at)
	VALUES(new.vendor_id,new.sub_category_id,new.product_id,v_page_imp_amount,v_button_click_amount,new.log_date,CURRENT_TIMESTAMP);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Inserted a record into variable_pay_logs table for the vendor_id ',new.vendor_id,' sub_category_id ',
	new.sub_category_id,' product_id ',new.product_id));


	SELECT SUM(total_impressions_amount), SUM(total_button_clicks_amount) INTO v_t_i_amount, v_t_bc_amount
	FROM monetization.variable_pay_logs WHERE vendor_id = new.vendor_id AND sub_category_id = new.sub_category_id
	AND product_id = new.product_id;

	SET v_total_amount = v_t_i_amount + v_t_bc_amount;


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure p_Insert_update_delete_cumulative_variable_pays');
	
	call p_Insert_update_delete_cumulative_variable_pays(new.vendor_id,
							     new.sub_category_id,
							     new.product_id,
							     v_total_amount,
							     new.log_date,
							     v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Procedure p_Insert_update_delete_cumulative_variable_pays executed successfully');

	END IF;

	END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);	
	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_update_vendor_product_transactions_logs AFTER UPDATE ON vendor_product_transactions_logs
    FOR EACH ROW
    BEGIN

	DECLARE v_i_rate_id, v_bc_rate_id, v_count INT;
	DECLARE v_impression_rates, v_button_click_rates, v_page_imp_amount, v_t_i_amount, v_t_bc_amount, v_button_click_amount, v_total_amount DOUBLE;
	DECLARE v_DebugID VARCHAR(255) DEFAULT 't_update_vendor_product_transactions_logs';

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	SELECT COUNT(*) INTO v_count FROM variable_pay_vendors
	WHERE vendor_id = new.vendor_id AND history_flag = 0;

	IF v_count > 0 THEN

	SELECT i_rate_id,bc_rate_id INTO v_i_rate_id,v_bc_rate_id FROM monetization.vendors_variable_pays
	WHERE vendor_id = new.vendor_id;

	SELECT impression_rates INTO v_impression_rates FROM monetization.impression_rates
	WHERE i_rate_id = v_i_rate_id;

	SELECT button_click_rates INTO v_button_click_rates FROM monetization.button_click_rates
	WHERE bc_rate_id = v_bc_rate_id;

	SET v_page_imp_amount = (new.page_impressions_count * v_impression_rates);
	SET v_button_click_amount = (new.button_clicks_count * v_button_click_rates);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Variable pay amounts are calculated successfully');

	UPDATE monetization.variable_pay_logs SET total_impressions_amount = v_page_imp_amount, 
	total_button_clicks_amount = v_button_click_amount, updated_at = CURRENT_TIMESTAMP
	WHERE vendor_id = new.vendor_id AND sub_category_id = new.sub_category_id AND
	product_id = new.product_id AND log_date = new.log_date;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Updated a record into variable_pay_logs table for the vendor_id ',new.vendor_id,' sub_category_id ',
	new.sub_category_id,' product_id ',new.product_id));


	SELECT SUM(total_impressions_amount), SUM(total_button_clicks_amount) INTO v_t_i_amount, v_t_bc_amount
	FROM monetization.variable_pay_logs WHERE vendor_id = new.vendor_id AND sub_category_id = new.sub_category_id
	AND product_id = new.product_id;

	SET v_total_amount = v_t_i_amount + v_t_bc_amount;


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure p_Insert_update_delete_cumulative_variable_pays');
	
	call p_Insert_update_delete_cumulative_variable_pays(new.vendor_id,
							     new.sub_category_id,
							     new.product_id,
							     v_total_amount,
							     new.log_date,
							     v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Procedure p_Insert_update_delete_cumulative_variable_pays executed successfully');

	END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);	
	
    END
    SQL
  end

  def down
    execute "DROP TRIGGER t_insert_vendor_product_transactions_logs"
    execute "DROP TRIGGER t_update_vendor_product_transactions_logs"
  end
end

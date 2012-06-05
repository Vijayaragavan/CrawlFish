class CreateTriggerOnVendorProductPurchasesLog < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_insert_vendor_products_purchases_logs"

    execute <<-SQL
    CREATE TRIGGER t_insert_vendor_products_purchases_logs AFTER INSERT ON vendor_product_purchases_logs
    FOR EACH ROW
    BEGIN

	DECLARE v_DebugID VARCHAR(255) DEFAULT 't_insert_vendor_product_purchases_logs';
	DECLARE v_commission_id, v_product_purchase_commissions, v_count INT;
	DECLARE v_pp_amount DOUBLE;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	SELECT COUNT(*) INTO v_count FROM product_purchase_commission_vendors
	WHERE vendor_id = new.vendor_id AND history_flag = 0;

	IF v_count > 0 THEN

	IF new.vendor_id > 0 AND new.sub_category_id > 0 AND new.product_id > 0 THEN

	SELECT commission_id INTO v_commission_id FROM monetization.vendors_product_purchase_commissions
	WHERE vendor_id = new.vendor_id AND sub_category_id = new.sub_category_id;

	SELECT product_purchase_commissions INTO v_product_purchase_commissions FROM monetization.product_purchase_commissions
	WHERE pp_commission_id = v_commission_id;

	SET v_pp_amount = ((new.product_purchase_amount * v_product_purchase_commissions)/100);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Product purchase commission amounts is calculated successfully');

	INSERT INTO monetization.product_purchase_commission_logs(vendor_id,sub_category_id,product_id,total_pp_comm_amount,log_date,created_at)
	VALUES(new.vendor_id,new.sub_category_id,new.product_id,v_pp_amount,new.log_date,CURRENT_TIMESTAMP);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Inserted a record into product_purchase_commission_logs table for the vendor_id ',new.vendor_id,' sub_category_id ',
	new.sub_category_id,' product_id ',new.product_id));


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure p_Insert_update_delete_cumulative_variable_pays');
	
	call p_Insert_update_delete_cumulative_variable_pays(new.vendor_id,
							     new.sub_category_id,
							     new.product_id,
							     v_pp_amount,
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
  end

  def down
    execute "DROP TRIGGER t_insert_vendor_products_purchases_logs"
  end
end

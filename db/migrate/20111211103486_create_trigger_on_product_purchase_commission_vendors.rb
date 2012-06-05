class CreateTriggerOnProductPurchaseCommissionVendors < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_product_purchase_commission_vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_product_purchase_commission_vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_product_purchase_commission_vendors"

    execute <<-SQL
    CREATE TRIGGER t_Insert_product_purchase_commission_vendors AFTER INSERT ON product_purchase_commission_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_product_purchase_commission_vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"purchase",
						new.vendor_id,
						new.sub_category_id,
						0,
						0,
						0,
						new.purchase_commission,
						new.subscribed_date,
						new.cut_off_period,
						new.cut_off_amount,
						new.history_flag);
	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_product_purchase_commission_vendors AFTER UPDATE ON product_purchase_commission_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Update_product_purchase_commission_vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"purchase",
						new.vendor_id,
						new.sub_category_id,
						0,
						0,
						0,
						new.purchase_commission,
						new.subscribed_date,
						new.cut_off_period,
						new.cut_off_amount,
						new.history_flag);
	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_product_purchase_commission_vendors AFTER DELETE ON product_purchase_commission_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Delete_product_purchase_commission_vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"purchase",
						old.vendor_id,
						old.sub_category_id,
						0,
						0,
						0,
						old.purchase_commission,
						old.subscribed_date,
						old.cut_off_period,
						old.cut_off_amount,
						1);
	
    END
    SQL

  end

  def down
    execute "DROP TRIGGER IF EXISTS t_Insert_product_purchase_commission_vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_product_purchase_commission_vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_product_purchase_commission_vendors"
  end
end

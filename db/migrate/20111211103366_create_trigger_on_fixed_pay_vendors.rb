class CreateTriggerOnFixedPayVendors < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Fixed_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_Fixed_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_Fixed_Pay_Vendors"

    execute <<-SQL
    CREATE TRIGGER t_Insert_Fixed_Pay_Vendors AFTER INSERT ON fixed_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_Fixed_Pay_Vendors';
   
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"fixed",
						new.vendor_id,
						0,
						new.accepted_amount,
						0,
						0,
						0,
						new.subscribed_date,
						new.cut_off_period,
						0,
						new.history_flag);


	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Fixed_Pay_Vendors AFTER UPDATE ON fixed_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Update_Fixed_Pay_Vendors';
    DECLARE v_count INT;
   
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    SELECT COUNT(*) INTO v_count FROM monetization.vendors_fixed_pays WHERE vendor_id = new.vendor_id;

    IF v_count = 0 THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Inserting the first record into vendors_fixed_pays');

    INSERT INTO monetization.vendor_financials(vendor_id, monetization_id, monetization_type, subscription_date, amount, paid_flag, history_flag, created_at)
    VALUES(old.vendor_id, 0, "fixed", new.subscribed_date, new.accepted_amount, 0, 0, CURRENT_TIMESTAMP);    

    END IF;


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"fixed",
						new.vendor_id,
						0,
						new.accepted_amount,
						0,
						0,
						0,
						new.subscribed_date,
						new.cut_off_period,
						0,
						new.history_flag);
	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_Fixed_Pay_Vendors AFTER DELETE ON fixed_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Delete_Fixed_Pay_Vendors';
   
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"fixed",
						old.vendor_id,
						0,
						old.accepted_amount,
						0,
						0,
						0,
						old.subscribed_date,
						old.cut_off_period,
						0,
						1);
	
    END
    SQL

  end

  def down
    execute "DROP TRIGGER IF EXISTS t_Insert_Fixed_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_Fixed_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_Fixed_Pay_Vendors"
  end
end

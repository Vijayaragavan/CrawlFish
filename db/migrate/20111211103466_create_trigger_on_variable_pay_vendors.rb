class CreateTriggerOnVariablePayVendors < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Variable_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_Variable_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_Variable_Pay_Vendors"

    execute <<-SQL
    CREATE TRIGGER t_Insert_Variable_Pay_Vendors AFTER INSERT ON variable_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_Variable_Pay_Vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"variable",
						new.vendor_id,
						0,
						0,
						new.accepted_impressions_rate,
						new.accepted_button_click_rate,
						0,
						new.subscribed_date,
						new.cut_off_period,
						new.cut_off_amount,
						new.history_flag);

	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Variable_Pay_Vendors AFTER UPDATE ON variable_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Update_Variable_Pay_Vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"variable",
						old.vendor_id,
						0,
						0,
						new.accepted_impressions_rate,
						new.accepted_button_click_rate,
						0,
						new.subscribed_date,
						new.cut_off_period,
						new.cut_off_amount,
						new.history_flag);
	
    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_Variable_Pay_Vendors AFTER DELETE ON variable_pay_vendors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Delete_Variable_Pay_Vendors';
    
    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure insert update delete vendor pays table');

	call p_Insert_update_delete_vendor_pays(v_DebugID,
						"variable",
						old.vendor_id,
						0,
						0,
						old.accepted_impressions_rate,
						old.accepted_button_click_rate,
						0,
						old.subscribed_date,
						old.cut_off_period,
						old.cut_off_amount,
						1);
	
    END
    SQL

  end

  def down
    execute "DROP TRIGGER IF EXISTS t_Insert_Variable_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Update_Variable_Pay_Vendors"
    execute "DROP TRIGGER IF EXISTS t_Delete_Variable_Pay_Vendors"
  end
end

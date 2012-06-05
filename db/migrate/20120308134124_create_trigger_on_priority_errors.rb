class CreateTriggerOnPriorityErrors < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_update_priority_errors"

    execute <<-SQL
    CREATE TRIGGER t_update_priority_errors AFTER UPDATE ON priority_errors
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_update_priority_errors';
    

    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

	UPDATE vendor_data_priorities SET priority_errors_flag = new.fixed
	WHERE product_name=new.product_name AND product_identifier1=new.identifier1 AND product_identifier2=new.identifier2;

	/* Insert a record in debug table for tracking the events */
	    call debug.debug_insert(v_DebugID,'Updated the records in vendor_data_priorities table for all the updates happened in priority_errors table');

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;
    SQL
  end

  def down
    execute "DROP TRIGGER t_update_priority_errors"
  end
end

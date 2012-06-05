class CreateTriggerOnTempTransactionsLog < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_insert_temp_transactions_logs"

    execute <<-SQL
    CREATE TRIGGER t_insert_temp_transactions_logs AFTER INSERT ON temp_transactions_logs
    FOR EACH ROW
    BEGIN

	DECLARE v_DebugID VARCHAR(255) DEFAULT 't_insert_temp_transactions_logs';

	/*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
	call debug.debug_on(v_DebugID);


	/* Calling the procedure p_Insert_transaction_logs */
	call debug.debug_insert(v_DebugID,'Procedure called to insert a record into vendor_product_transactions_log');
	
	call p_Insert_transaction_logs (v_DebugID, new.unique_id, new.type, new.log_date);


	/* Ending the debug table insert with a #(pound) mark */
    	call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TRIGGER t_insert_temp_transactions_logs"
  end
end

class CreateTriggerOnMerchantsLists < ActiveRecord::Migration
   def up

    execute <<-SQL
    CREATE TRIGGER t_insert_merchants_lists AFTER INSERT ON merchants_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_insert_merchants_lists';
    DECLARE v_merchants_list_id INT;
    DECLARE v_count INT;

    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

    SELECT COUNT(*) INTO v_count FROM priority_requests
    WHERE merchants_list_id = new.merchants_list_id;

    IF v_count = 0 THEN

        INSERT INTO priority_requests(request,request_type,merchants_list_id,created_at)
        VALUES("A new merchant has requested to sign up with CrawlFish","add_vendor",new.merchants_list_id,CURRENT_TIMESTAMP);

        /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('A merchant with merchants_list_id ',new.merchants_list_id,' has requested for a sign up'));

        ELSE

        /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('The merchant with merchants_list_id ',new.merchants_list_id,' already exists, insert abort!'));

      END IF;

       /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

      END;
    SQL
  end

  def down

    execute "DROP TRIGGER IF EXISTS t_insert_merchants_lists"

  end
end


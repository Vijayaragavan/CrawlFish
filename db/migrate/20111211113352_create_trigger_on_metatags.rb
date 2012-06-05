class CreateTriggerOnMetatags < ActiveRecord::Migration
  def up
    execute "DROP TRIGGER IF EXISTS t_Insert_metatags"
    execute "DROP TRIGGER IF EXISTS t_Update_metatags"

    execute <<-SQL
    CREATE TRIGGER t_Insert_metatags AFTER INSERT ON metatags
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_Insert_metatags';

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,CONCAT('New metatag value ',new.metatag,' has been inserted into metatags table'));

     call p_Insert_filters_collections( NULL, new.metatag,
                                       new.primary_id,
                                       new.model_name,
                                       new.column_name,
                                       new.sub_category_id,
                                       v_DebugID);


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_metatags BEFORE UPDATE ON metatags
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_Update_metatags';
    DECLARE v_filters_collection_id INT;

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);


    SELECT filters_collection_id INTO v_filters_collection_id FROM filters_collections
    WHERE f_stripstring(filter_key) = f_stripstring(old.metatag) AND filter_table_name = old.model_name AND filter_table_column = old.column_name
    AND filter_id = old.primary_id AND sub_category_id = old.sub_category_id;


    IF new.metatag IS NOT NULL THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('filters_collection_id is ',v_filters_collection_id));

    UPDATE filters_collections SET filter_key = new.metatag
    WHERE filters_collection_id = v_filters_collection_id;

    END IF;

    IF new.model_name IS NOT NULL THEN

    UPDATE filters_collections SET filter_table_name = new.model_name
    WHERE filters_collection_id = v_filters_collection_id;

    END IF;

    IF new.column_name IS NOT NULL THEN

    UPDATE filters_collections SET filter_table_column = new.column_name
    WHERE filters_collection_id = v_filters_collection_id;

    END IF;

    IF new.primary_id IS NOT NULL THEN

    UPDATE filters_collections SET filter_id = new.primary_id
    WHERE filters_collection_id = v_filters_collection_id;

    END IF;

    IF new.sub_category_id IS NOT NULL THEN

    UPDATE filters_collections SET filter_id = new.primary_id
    WHERE filters_collection_id = v_filters_collection_id;

    END IF;


    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Metatag values have been updated into filters collection table');

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TRIGGER t_Insert_metatags"
    execute "DROP TRIGGER t_Update_metatags"
  end
end

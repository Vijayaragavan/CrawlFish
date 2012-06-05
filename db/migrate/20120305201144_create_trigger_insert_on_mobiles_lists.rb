class CreateTriggerInsertOnMobilesLists < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Mobiles_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Mobiles_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Mobiles_Lists"


    execute <<-SQL
    CREATE TRIGGER t_Insert_Mobiles_Lists AFTER INSERT ON mobiles_lists
    FOR EACH ROW
    BEGIN

    /* declaring the variables required for parsing mobile features */
    DECLARE  v_mobile_name_id,v_mobile_brand_id,v_mobile_color_id,v_mobile_type_id,v_mobile_design_id,v_os_version_id,v_os_version_name_id,v_release_date_id,
    v_touch_screen_id,v_internal_storage_id,v_card_slot_id,v_primary_camera_id,v_secondary_camera_id,v_processor_id,v_mobile_ram_id, v_messaging_id,v_browser_id,v_assorteds_id,v_availability_id,v_sub_category_id INT;


    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_I_M_',new.mobiles_list_id,'_',new.mobile_name);



    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);


     DROP TEMPORARY TABLE IF EXISTS productfeatures;
     DROP TEMPORARY TABLE IF EXISTS attributes;

     IF f_createproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not created');

    END IF;

     IF f_createattributes() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table attributes is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The attributes table is not created');

    END IF;



     IF f_productfeatures(new.mobile_features,16) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The mobile features are extracted from mobiles_lists, parsed
    and saved into productfeatures table, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The mobile features are not successfully saved into productfeatures table');

    END IF;

    /* call the following procedures to insert/ignore a mobile feature from mobiles_lists table into index tables based */
    /* on its non-existence/existence respectively */




    call p_Insert_mobiles_f1_mobile_brands(v_DebugID,v_mobile_brand_id);

    call p_Insert_link_f1_mobiles_lists(new.mobiles_list_id,v_mobile_brand_id,v_DebugID);


    call p_Insert_mobiles_f2_mobile_colors(v_DebugID,v_mobile_color_id);

    call p_Insert_link_f2_mobiles_lists(new.mobiles_list_id, v_mobile_color_id, v_DebugID);


    call p_Insert_mobiles_f3_mobile_types(v_DebugID);

    call p_Insert_link_f3_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f4_mobile_designs(v_DebugID,v_mobile_design_id);

    call p_Insert_link_f4_mobiles_lists(new.mobiles_list_id, v_mobile_design_id, v_DebugID);


    call p_Insert_mobiles_f5_os_versions(v_DebugID,v_os_version_id,v_os_version_name_id);

    call p_Insert_link_f5_mobiles_lists(new.mobiles_list_id, v_os_version_id, v_DebugID);

    call p_Insert_link_f5_c_mobiles_lists(new.mobiles_list_id, v_os_version_name_id, v_DebugID);


    call p_Insert_mobiles_f6_touch_screens(v_DebugID,v_touch_screen_id);

    call p_Insert_link_f6_mobiles_lists(new.mobiles_list_id, v_touch_screen_id, v_DebugID);


    call p_Insert_mobiles_f7_internal_storages(v_DebugID,v_internal_storage_id);

    call p_Insert_link_f7_mobiles_lists(new.mobiles_list_id, v_internal_storage_id, v_DebugID);


    call p_Insert_mobiles_f8_card_slots(v_DebugID,v_card_slot_id);

    call p_Insert_link_f8_mobiles_lists(new.mobiles_list_id, v_card_slot_id, v_DebugID);


    call p_Insert_mobiles_f9_primary_cameras(v_DebugID,v_primary_camera_id);

    call p_Insert_link_f9_mobiles_lists(new.mobiles_list_id, v_primary_camera_id, v_DebugID);


    call p_Insert_mobiles_f10_secondary_cameras(v_DebugID,v_secondary_camera_id);

    call p_Insert_link_f10_mobiles_lists(new.mobiles_list_id, v_secondary_camera_id, v_DebugID);


    call p_Insert_mobiles_f11_processors(v_DebugID,v_processor_id);

    call p_Insert_link_f11_mobiles_lists(new.mobiles_list_id, v_processor_id, v_DebugID);


    call p_Insert_mobiles_f12_messagings(v_DebugID);

    call p_Insert_link_f12_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f13_browsers(v_DebugID);

    call p_Insert_link_f13_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f14_mobile_rams(v_DebugID,v_mobile_ram_id);

    call p_Insert_link_f14_mobiles_lists(new.mobiles_list_id, v_mobile_ram_id, v_DebugID);


    call p_Insert_link_f15_mobiles_lists(new.mobiles_list_id, v_DebugID);



     IF f_flushproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is dropped successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not dropped successfully');

    END IF;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure to check priority error table');

    call p_Check_priority_table("mobiles_lists",new.mobile_name,new.mobile_brand,new.mobile_color);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Mobiles_Lists AFTER UPDATE ON mobiles_lists
    FOR EACH ROW
    BEGIN

    /* declaring the variables required for parsing mobile features */
    DECLARE  v_mobile_name_id,v_mobile_brand_id,v_mobile_color_id,v_mobile_type_id,v_mobile_design_id,v_os_version_id,v_os_version_name_id,v_release_date_id,
    v_touch_screen_id,v_internal_storage_id,v_card_slot_id,v_primary_camera_id,v_secondary_camera_id,v_processor_id,v_mobile_ram_id, v_messaging_id,v_browser_id,v_assorteds_id,v_availability_id,v_sub_category_id INT;


    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_U_M_',new.mobiles_list_id,'_',new.mobile_name);



    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);


     DROP TEMPORARY TABLE IF EXISTS productfeatures;
     DROP TEMPORARY TABLE IF EXISTS attributes;

     IF f_createproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not created');

    END IF;

     IF f_createattributes() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table attributes is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The attributes table is not created');

    END IF;



     IF f_productfeatures(new.mobile_features,16) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The mobile features are extracted from mobiles_lists, parsed
    and saved into productfeatures table, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The mobile features are not successfully saved into productfeatures table');

    END IF;

    /* call the following procedures to update/ignore a mobile feature from mobiles_lists table into index tables based */
    /* on its non-existence/existence respectively */




    call p_Insert_mobiles_f1_mobile_brands(v_DebugID,v_mobile_brand_id);

    call p_Insert_link_f1_mobiles_lists(new.mobiles_list_id,v_mobile_brand_id,v_DebugID);


    call p_Insert_mobiles_f2_mobile_colors(v_DebugID,v_mobile_color_id);

    call p_Insert_link_f2_mobiles_lists(new.mobiles_list_id, v_mobile_color_id, v_DebugID);


    call p_Insert_mobiles_f3_mobile_types(v_DebugID);

    call p_Insert_link_f3_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f4_mobile_designs(v_DebugID,v_mobile_design_id);

    call p_Insert_link_f4_mobiles_lists(new.mobiles_list_id, v_mobile_design_id, v_DebugID);


    call p_Insert_mobiles_f5_os_versions(v_DebugID,v_os_version_id,v_os_version_name_id);

    call p_Insert_link_f5_mobiles_lists(new.mobiles_list_id, v_os_version_id, v_DebugID);

    call p_Insert_link_f5_c_mobiles_lists(new.mobiles_list_id, v_os_version_name_id, v_DebugID);


    call p_Insert_mobiles_f6_touch_screens(v_DebugID,v_touch_screen_id);

    call p_Insert_link_f6_mobiles_lists(new.mobiles_list_id, v_touch_screen_id, v_DebugID);


    call p_Insert_mobiles_f7_internal_storages(v_DebugID,v_internal_storage_id);

    call p_Insert_link_f7_mobiles_lists(new.mobiles_list_id, v_internal_storage_id, v_DebugID);


    call p_Insert_mobiles_f8_card_slots(v_DebugID,v_card_slot_id);

    call p_Insert_link_f8_mobiles_lists(new.mobiles_list_id, v_card_slot_id, v_DebugID);


    call p_Insert_mobiles_f9_primary_cameras(v_DebugID,v_primary_camera_id);

    call p_Insert_link_f9_mobiles_lists(new.mobiles_list_id, v_primary_camera_id, v_DebugID);


    call p_Insert_mobiles_f10_secondary_cameras(v_DebugID,v_secondary_camera_id);

    call p_Insert_link_f10_mobiles_lists(new.mobiles_list_id, v_secondary_camera_id, v_DebugID);


    call p_Insert_mobiles_f11_processors(v_DebugID,v_processor_id);

    call p_Insert_link_f11_mobiles_lists(new.mobiles_list_id, v_processor_id, v_DebugID);


    call p_Insert_mobiles_f12_messagings(v_DebugID);

    call p_Insert_link_f12_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f13_browsers(v_DebugID);

    call p_Insert_link_f13_mobiles_lists(new.mobiles_list_id, v_DebugID);


    call p_Insert_mobiles_f14_mobile_rams(v_DebugID,v_mobile_ram_id);

    call p_Insert_link_f14_mobiles_lists(new.mobiles_list_id, v_mobile_ram_id, v_DebugID);


    call p_Insert_link_f15_mobiles_lists(new.mobiles_list_id, v_DebugID);



     IF f_flushproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is dropped successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not dropped successfully');

    END IF;



    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Delete_Mobiles_Lists BEFORE DELETE ON mobiles_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_D_M_',old.mobiles_list_id,'_',old.mobile_name);



    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	   
    call p_Delete_link_f1_mobiles_lists(old.mobiles_list_id,v_DebugID);


    call p_Delete_link_f2_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f3_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f4_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f5_mobiles_lists(old.mobiles_list_id, v_DebugID);
    call p_Delete_link_f5_c_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f6_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f7_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f8_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f9_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f10_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f11_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f12_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f13_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f14_mobiles_lists(old.mobiles_list_id, v_DebugID);


    call p_Delete_link_f15_mobiles_lists(old.mobiles_list_id, v_DebugID);


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL




  end

  def down

    execute "DROP TRIGGER t_Insert_Mobiles_Lists"
    execute "DROP TRIGGER t_Update_Mobiles_Lists"
    execute "DROP TRIGGER t_Delete_Mobiles_Lists"

  end
end


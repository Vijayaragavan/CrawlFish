class CreateProcedureInsertIntoMobilesIndexTables < ActiveRecord::Migration
  def up

  

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f1_mobile_brands(IN v1_debugid VARCHAR(255),
                                          OUT v1_mobile_brand_id INT)
     BEGIN

     DECLARE v_mobile_brand_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_mobile_brand_name
     FROM productfeatures
     WHERE id = 1;

     IF lower(v_mobile_brand_name) = "n.a." THEN
     SELECT 0 INTO v1_mobile_brand_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_brand value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f1_mobile_brands
     WHERE f_stripstring(mobile_brand_name)= f_stripstring(v_mobile_brand_name);

     IF v_COUNT = 0 THEN
	

	     INSERT INTO mobiles_f1_mobile_brands(mobile_brand_name,
          	                         created_at)
	     values(v_mobile_brand_name,
        	    CURRENT_TIMESTAMP);

	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'A mobile_brand name is inserted into mobiles_f1_mobile_brands, about a nanosecond ago');


     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_brand name already exists so, the insert is aborted');


     END IF;

     SELECT mobile_brand_id
     INTO v1_mobile_brand_id
     FROM mobiles_f1_mobile_brands
     WHERE f_stripstring(mobile_brand_name)= f_stripstring(v_mobile_brand_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f2_mobile_colors(IN v1_debugid VARCHAR(255),
                                          OUT v1_mobile_color_id INT)
     BEGIN

     DECLARE v_mobile_color_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_mobile_color_name
     FROM productfeatures
     WHERE id = 2;

     IF lower(v_mobile_color_name) = "n.a." THEN
     SELECT 0 INTO v1_mobile_color_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_color value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f2_mobile_colors
     WHERE f_stripstring(mobile_color_name)= f_stripstring(v_mobile_color_name);

     IF v_COUNT = 0 THEN
	

	     INSERT INTO mobiles_f2_mobile_colors(mobile_color_name,
          	                         created_at)
	     values(v_mobile_color_name,
        	    CURRENT_TIMESTAMP);

	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'A mobile_color name is inserted into mobiles_f2_mobile_colors, about a nanosecond ago');


     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_color name already exists so, the insert is aborted');


     END IF;

     SELECT mobile_color_id
     INTO v1_mobile_color_id
     FROM mobiles_f2_mobile_colors
     WHERE f_stripstring(mobile_color_name)= f_stripstring(v_mobile_color_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f3_mobile_types(IN v1_debugid VARCHAR(255))

     BEGIN

     DECLARE v_mobile_type_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_mobile_type_name
     FROM productfeatures
     WHERE id = 3;

     call p_Split_feature_names(v_mobile_type_name,"mobile_type");

     call p_Insert_each_mobile_types_names(v1_debugid);


     END

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f4_mobile_designs(IN v1_debugid VARCHAR(255),
                                          OUT v1_mobile_design_id INT)
     BEGIN

     DECLARE v_mobile_design_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_mobile_design_name
     FROM productfeatures
     WHERE id = 4;

     IF lower(v_mobile_design_name) = "n.a." THEN
     SELECT 0 INTO v1_mobile_design_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_design_name value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f4_mobile_designs
     WHERE f_stripstring(mobile_design_name)= f_stripstring(v_mobile_design_name);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f4_mobile_designs(mobile_design_name,
                                   created_at)
     values(v_mobile_design_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A mobile_design name is inserted into mobiles_f4_mobile_designs, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_design name already exists so, the insert is aborted');


     END IF;

     SELECT mobile_design_id
     INTO v1_mobile_design_id
     FROM mobiles_f4_mobile_designs
     WHERE f_stripstring(mobile_design_name)= f_stripstring(v_mobile_design_name);

     END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f5_os_versions(IN v1_debugid VARCHAR(255),
                                          OUT v1_os_version_id INT, OUT v1_os_version_name_id INT)
     BEGIN

     DECLARE v_operating_system_name, v_os_version, v_os_version_name VARCHAR(255);
     DECLARE v_COUNT INT;


     SELECT val
     INTO v_operating_system_name
     FROM productfeatures
     WHERE id = 5;

     IF f_splitattributes(v_operating_system_name,2) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The mobile OS name is extracted from product features table, parsed the attribute values
    and saved into splitattributes table, about a nanosecond ago');

     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The mobile OS attibutes are not successfully saved into splitattributes table');

     END IF;

     SELECT val INTO v_os_version FROM attributes WHERE id = 1;
     SELECT val INTO v_os_version_name FROM attributes WHERE id = 2;

     IF lower(v_os_version) = "n.a." THEN
     SELECT 0 INTO v1_os_version_id;
     SELECT 0 INTO v1_os_version_name_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The os_version value is not a valid one so, the insert is aborted');

     ELSE

	IF lower(v_os_version_name) = "n.a." THEN
	SELECT 0 INTO v1_os_version_name_id;

    	 /* Insert a record in debug table for tracking the events */
     	 call debug.debug_insert(v1_debugid,'The os_version_name value is not a valid one so, it is not inserted in the child table');

	ELSE
	
	SELECT COUNT(*) INTO v_COUNT FROM mobiles_f5_c_os_version_names
	WHERE f_stripstring(mobile_os_version_name)= f_stripstring(v_os_version_name);

	IF v_COUNT = 0 THEN

	INSERT INTO mobiles_f5_c_os_version_names(mobile_os_version_name,created_at)
    	values(v_os_version_name,CURRENT_TIMESTAMP);

	SELECT mobile_os_version_name_id INTO v1_os_version_name_id FROM mobiles_f5_c_os_version_names
        WHERE f_stripstring(mobile_os_version_name)= f_stripstring(v_os_version_name);

   	   /* Insert a record in debug table for tracking the events */
   	   call debug.debug_insert(v1_debugid,'An operating_system name is inserted into mobiles_f5_os_versions, about a nanosecond ago');

        ELSE

	SELECT mobile_os_version_name_id INTO v1_os_version_name_id FROM mobiles_f5_c_os_version_names
        WHERE f_stripstring(mobile_os_version_name)= f_stripstring(v_os_version_name);        

	END IF;
 
	END IF;

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f5_os_versions
     WHERE f_stripstring(mobile_os_version)= f_stripstring(v_os_version);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f5_os_versions(mobile_os_version,mobile_os_version_name_id,created_at)
     values(v_os_version,v1_os_version_name_id,CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'An operating_system version is inserted into mobiles_f5_os_versions, about a nanosecond ago');    

     END IF;

     SELECT mobile_os_version_id
     INTO v1_os_version_id
     FROM mobiles_f5_os_versions
     WHERE f_stripstring(mobile_os_version)= f_stripstring(v_os_version) AND f_stripstring(mobile_os_version_name_id)= f_stripstring(v1_os_version_name_id);

     END IF; 

     IF f_flushattributes() THEN
	call debug.debug_insert(v1_debugid,'Temporary table dropped after inserting mobile os');
     ELSE
	call debug.debug_insert(v1_debugid,'Temporary table not dropped, after inserting mobile os');
     END IF;


    END;

   SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f6_touch_screens(IN v1_debugid VARCHAR(255),
                                          OUT v1_touch_screen_id INT)
     BEGIN

     DECLARE v_touch_screen_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_touch_screen_name
     FROM productfeatures
     WHERE id = 6;

     IF lower(v_touch_screen_name) = "n.a." THEN
     SELECT 0 INTO v1_touch_screen_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The touch_screen_name value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f6_touch_screens
     WHERE f_stripstring(touch_screen_name)= f_stripstring(v_touch_screen_name);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f6_touch_screens(touch_screen_name,
                                   created_at)
     values(v_touch_screen_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A touch_screen name is inserted into mobiles_f6_touch_screens, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The touch_screen name already exists so, the insert is aborted');


     END IF;

     SELECT touch_screen_id
     INTO v1_touch_screen_id
     FROM mobiles_f6_touch_screens
     WHERE f_stripstring(touch_screen_name)= f_stripstring(v_touch_screen_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f7_internal_storages(IN v1_debugid VARCHAR(255),
                                          OUT v1_internal_storage_id INT)
     BEGIN

     DECLARE v_internal_storage_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_internal_storage_name
     FROM productfeatures
     WHERE id = 7;

     IF lower(v_internal_storage_name) = "n.a." THEN
     SELECT 0 INTO v1_internal_storage_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The internal_storage_name value is not a valid one so, the insert is aborted');

     ELSE


     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f7_internal_storages
     WHERE f_stripstring(internal_storage_name)= f_stripstring(v_internal_storage_name);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f7_internal_storages(internal_storage_name,
                                   created_at)
     values(v_internal_storage_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A internal_storage name is inserted into mobiles_f7_internal_storages, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The internal_storage name already exists so, the insert is aborted');


     END IF;

     SELECT internal_storage_id
     INTO v1_internal_storage_id
     FROM mobiles_f7_internal_storages
     WHERE f_stripstring(internal_storage_name)= f_stripstring(v_internal_storage_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f8_card_slots(IN v1_debugid VARCHAR(255),
                                          OUT v1_card_slot_id INT)
     BEGIN

     DECLARE v_card_slot_name, v_card_slot_type, v_memory_size, v_card_slots VARCHAR(255);
     DECLARE v_COUNT INT;

     IF f_createattributes() THEN
	call debug.debug_insert(v1_debugid,'Temporary table created before inserting card_slot');
     ELSE
	call debug.debug_insert(v1_debugid,'Temporary table not created before inserting card_slot');
     END IF;

     SELECT val
     INTO v_card_slot_name
     FROM productfeatures
     WHERE id = 8;

     IF f_splitattributes(v_card_slot_name,2) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The Card Slot name is extracted from product features table, parsed the attribute values
    and saved into splitattributes table, about a nanosecond ago');

     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The Card Slot attibutes are not successfully saved into splitattributes table');

     END IF;

     SELECT val INTO v_card_slot_type FROM attributes WHERE id = 1;
     SELECT val INTO v_memory_size FROM attributes WHERE id = 2;

     SET v_card_slots = CONCAT(v_card_slot_type,' ',v_memory_size);	

     IF lower(v_card_slot_type) = "n.a." THEN
     SELECT 0 INTO v1_card_slot_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The card_slot_type value is not a valid one so, the insert is aborted');

     ELSE
 
     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f8_card_slots
     WHERE f_stripstring(card_slots)= f_stripstring(v_card_slots);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f8_card_slots(card_slots,created_at)
     values(v_card_slots,CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A card_slot is inserted into mobiles_f8_card_slots, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The card_slot already exists so, the insert is aborted');


     END IF;

     SELECT card_slot_id
     INTO v1_card_slot_id
     FROM mobiles_f8_card_slots
     WHERE f_stripstring(card_slots)= f_stripstring(v_card_slots);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('The card_slot_id is ',v1_card_slot_id));

     END IF;

     IF f_flushattributes() THEN
	call debug.debug_insert(v1_debugid,'Temporary table dropped after inserting card slot');
     ELSE
	call debug.debug_insert(v1_debugid,'Temporary table not dropped, after inserting card slot');
     END IF;

    END;

   SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f9_primary_cameras(IN v1_debugid VARCHAR(255),
                                          OUT v1_primary_camera_id INT)
     BEGIN

     DECLARE v_primary_camera_name, v_primary_camera VARCHAR(255);
     DECLARE v_COUNT INT;

     IF f_createattributes() THEN
	call debug.debug_insert(v1_debugid,'Temporary table created before inserting primary camera value');
     ELSE
	call debug.debug_insert(v1_debugid,'Temporary table not created before inserting primary camera value');
     END IF;

     SELECT val
     INTO v_primary_camera_name
     FROM productfeatures
     WHERE id = 9;

     IF f_splitattributes(v_primary_camera_name,2) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The Primary Camera name is extracted from product features table, parsed the attribute values
    and saved into splitattributes table, about a nanosecond ago');

     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'The Primary Camera value is not successfully saved into splitattributes table');

     END IF;

     SELECT val INTO v_primary_camera FROM attributes WHERE id = 1;


     IF lower(v_primary_camera) = "n.a." THEN
     SELECT 0 INTO v1_primary_camera_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The primary_camera value is not a valid one so, the insert is aborted');

     ELSE


     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f9_primary_cameras
     WHERE f_stripstring(primary_camera)= f_stripstring(v_primary_camera);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f9_primary_cameras(primary_camera,
                                   created_at)
     values(v_primary_camera,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A primary_camera name is inserted into mobiles_f9_primary_cameras, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The primary_camera name already exists so, the insert is aborted');


     END IF;

     SELECT primary_camera_id
     INTO v1_primary_camera_id
     FROM mobiles_f9_primary_cameras
     WHERE f_stripstring(primary_camera)= f_stripstring(v_primary_camera);

     IF f_flushattributes() THEN
	call debug.debug_insert(v1_debugid,'Temporary table dropped after inserting primary camera');
     ELSE
	call debug.debug_insert(v1_debugid,'Temporary table not dropped, after inserting primary camera');
     END IF;

    END IF;

    END;

   SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f10_secondary_cameras(IN v1_debugid VARCHAR(255),
                                          OUT v1_secondary_camera_id INT)
     BEGIN

     DECLARE v_secondary_camera_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_secondary_camera_name
     FROM productfeatures
     WHERE id = 10;

     IF lower(v_secondary_camera_name) = "n.a." THEN
     SELECT 0 INTO v1_secondary_camera_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The secondary_camera value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f10_secondary_cameras
     WHERE f_stripstring(secondary_camera)= f_stripstring(v_secondary_camera_name);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f10_secondary_cameras(secondary_camera,
                                   created_at)
     values(v_secondary_camera_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A secondary_camera name is inserted into mobiles_f10_secondary_cameras, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The secondary_camera name already exists so, the insert is aborted');


     END IF;

     SELECT secondary_camera_id
     INTO v1_secondary_camera_id
     FROM mobiles_f10_secondary_cameras
     WHERE f_stripstring(secondary_camera)= f_stripstring(v_secondary_camera_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f11_processors(IN v1_debugid VARCHAR(255),
                                          OUT v1_processor_id INT)
     BEGIN

     DECLARE v_processor_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_processor_name
     FROM productfeatures
     WHERE id = 11;

     IF lower(v_processor_name) = "n.a." THEN
     SELECT 0 INTO v1_processor_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The processor_name value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f11_processors
     WHERE f_stripstring(processor)= f_stripstring(v_processor_name);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f11_processors(processor,
                                   created_at)
     values(v_processor_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A processor name is inserted into mobiles_f11_processors, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The processor name already exists so, the insert is aborted');


     END IF;

     SELECT processor_id
     INTO v1_processor_id
     FROM mobiles_f11_processors
     WHERE f_stripstring(processor)= f_stripstring(v_processor_name);

    END IF;

    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f12_messagings(IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_messaging_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_messaging_name
     FROM productfeatures
     WHERE id = 12;

     call p_Split_feature_names(v_messaging_name,"messaging");

     call p_Insert_each_messaging_names(v1_debugid);

     END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f13_browsers(IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_browser_name VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_browser_name
     FROM productfeatures
     WHERE id = 13;

     call p_Split_feature_names(v_browser_name,"browser");

     call p_Insert_each_browser_names(v1_debugid);


    END;

   SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_mobiles_f14_mobile_rams(IN v1_debugid VARCHAR(255),
                                          OUT v1_mobile_ram_id INT)
     BEGIN

     DECLARE v_mobile_ram VARCHAR(255);
     DECLARE v_COUNT INT;

     SELECT val
     INTO v_mobile_ram
     FROM productfeatures
     WHERE id = 14;

     IF lower(v_mobile_ram) = "n.a." THEN
     SELECT 0 INTO v1_mobile_ram_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_ram value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM mobiles_f14_mobile_rams
     WHERE f_stripstring(mobile_ram)= f_stripstring(v_mobile_ram);

     IF v_COUNT = 0 THEN

     INSERT INTO mobiles_f14_mobile_rams(mobile_ram,
                                   created_at)
     values(v_mobile_ram,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A mobile_ram is inserted into mobiles_f14_mobile_rams, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The mobile_ram already exists so, the insert is aborted');


     END IF;

     SELECT mobile_ram_id
     INTO v1_mobile_ram_id
     FROM mobiles_f14_mobile_rams
     WHERE f_stripstring(mobile_ram)= f_stripstring(v_mobile_ram);

    END IF;

    END;

   SQL
    


  end

  def down

    execute "DROP PROCEDURE p_Insert_mobiles_f1_mobile_brands"

    execute "DROP PROCEDURE p_Insert_mobiles_f2_mobile_colors"

    execute "DROP PROCEDURE p_Insert_mobiles_f3_mobile_types"

    execute "DROP PROCEDURE p_Insert_mobiles_f4_mobile_designs"

    execute "DROP PROCEDURE p_Insert_mobiles_f5_os_versions"

    execute "DROP PROCEDURE p_Insert_mobiles_f6_touch_screens"

    execute "DROP PROCEDURE p_Insert_mobiles_f7_internal_storages"

    execute "DROP PROCEDURE p_Insert_mobiles_f8_card_slots"

    execute "DROP PROCEDURE p_Insert_mobiles_f9_primary_cameras"

    execute "DROP PROCEDURE p_Insert_mobiles_f10_secondary_cameras"

    execute "DROP PROCEDURE p_Insert_mobiles_f11_processors"

    execute "DROP PROCEDURE p_Insert_mobiles_f12_messagings"

    execute "DROP PROCEDURE p_Insert_mobiles_f13_browsers"

    execute "DROP PROCEDURE p_Insert_mobiles_f14_mobile_rams"

  end
end


class CreateProcedureInsertUpdateLinkMobilesLists < ActiveRecord::Migration
  def up


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f1_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_brand_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;

     IF v1_mobile_brand_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f1_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f1_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f1_mobiles_lists 
     SET mobile_brand_id = v1_mobile_brand_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been created in link_f1_mobiles_lists');


     ELSE

     INSERT INTO link_f1_mobiles_lists(mobiles_list_id,
                                     mobile_brand_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_brand_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_brand_id ',v1_mobile_brand_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
     END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f2_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_color_id INT,
                                                  IN v1_debugid VARCHAR(255))

     BEGIN

     DECLARE v_COUNT INT;

     IF v1_mobile_color_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f2_mobiles_lists');

     ELSE


     SELECT COUNT(*) INTO v_COUNT FROM link_f2_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f2_mobiles_lists 
     SET mobile_color_id = v1_mobile_color_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f2_mobiles_lists');


     ELSE

     INSERT INTO link_f2_mobiles_lists(mobiles_list_id,
                                     mobile_color_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_color_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_color_id ',v1_mobile_color_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f3_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;
     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_mobile_type_id INT;

     SELECT COUNT(*)
     INTO quantity
     FROM features;

     DELETE FROM link_f3_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     carrier_loop: LOOP
     IF loopcounter <= quantity THEN

              SELECT features_id
              INTO v1_mobile_type_id
              FROM features
              WHERE id = loopcounter;

	     IF v1_mobile_type_id = 0 THEN
   		  /* Insert a record in debug table for tracking the events */
   		   call debug.debug_insert(v1_debugid,'No record is inserted into link_f3_mobiles_lists');

   	     ELSE

	     SELECT COUNT(*) INTO v_COUNT
	     FROM link_f3_mobiles_lists
	     WHERE mobiles_list_id = v1_mobiles_list_id AND mobile_type_id = v1_mobile_type_id;

	     IF v_COUNT = 0 THEN	
		IF v1_mobile_type_id IS NOT NULL THEN

		     INSERT INTO link_f3_mobiles_lists(mobiles_list_id,
                                     mobile_type_id,
                                     created_at)
		     values(v1_mobiles_list_id,
	        	    v1_mobile_type_id,
	        	    CURRENT_TIMESTAMP);

		      /* Insert a record in debug table for tracking the events */
		      call debug.debug_insert(v1_debugid,concat('A link for the mobile_type_id ',v1_mobile_type_id,' and mobiles_list_id ',v1_mobiles_list_id,
		      ' is created, about a nanosecond ago'));
 		END IF;
             ELSE

	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'No link is created in link_f3_mobiles_lists');
             END IF;
	    END IF;

     ELSE
              LEAVE carrier_loop;
     END IF;
     SET loopcounter = loopcounter + 1;
     END LOOP carrier_loop;

     drop temporary table if exists features;

     END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f4_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_design_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_mobile_design_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f4_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f4_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f4_mobiles_lists 
     SET mobile_design_id = v1_mobile_design_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f4_mobiles_lists');


     ELSE

     INSERT INTO link_f4_mobiles_lists(mobiles_list_id,
                                     mobile_design_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_design_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_design_id ',v1_mobile_design_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f5_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_os_version_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_mobile_os_version_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f5_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f5_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f5_mobiles_lists 
     SET mobile_os_version_id = v1_mobile_os_version_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f5_mobiles_lists');


     ELSE

     INSERT INTO link_f5_mobiles_lists(mobiles_list_id,
                                     mobile_os_version_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_os_version_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_os_version_id ',v1_mobile_os_version_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f5_c_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_os_version_name_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_mobile_os_version_name_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f5_c_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f5_c_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f5_c_mobiles_lists 
     SET mobile_os_version_name_id = v1_mobile_os_version_name_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f5_c_mobiles_lists');


     ELSE

     INSERT INTO link_f5_c_mobiles_lists(mobiles_list_id,
                                     mobile_os_version_name_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_os_version_name_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_os_version_name_id ',v1_mobile_os_version_name_id,' and mobiles_list_id ',v1_mobiles_list_id,' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL



    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f6_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_touch_screen_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_touch_screen_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f6_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f6_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f6_mobiles_lists 
     SET touch_screen_id = v1_touch_screen_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f6_mobiles_lists');


     ELSE

     INSERT INTO link_f6_mobiles_lists(mobiles_list_id,
                                     touch_screen_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_touch_screen_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the touch_screen_id ',v1_touch_screen_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;


    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f7_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_internal_storage_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_internal_storage_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f7_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f7_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f7_mobiles_lists 
     SET internal_storage_id = v1_internal_storage_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f7_mobiles_lists');


     ELSE

     INSERT INTO link_f7_mobiles_lists(mobiles_list_id,
                                     internal_storage_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_internal_storage_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the internal_storage_id ',v1_internal_storage_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f8_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_card_slot_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_card_slot_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f8_mobiles_lists');

     ELSE


     SELECT COUNT(*) INTO v_COUNT FROM link_f8_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f8_mobiles_lists 
     SET card_slot_id = v1_card_slot_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f8_mobiles_lists');


     ELSE

     INSERT INTO link_f8_mobiles_lists(mobiles_list_id,
                                     card_slot_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_card_slot_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the card_slot_id ',v1_card_slot_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f9_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_primary_camera_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_primary_camera_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f9_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f9_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f9_mobiles_lists 
     SET primary_camera_id = v1_primary_camera_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f9_mobiles_lists');


     ELSE

     INSERT INTO link_f9_mobiles_lists(mobiles_list_id,
                                     primary_camera_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_primary_camera_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the primary_camera_id ',v1_primary_camera_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
    END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f10_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_secondary_camera_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_secondary_camera_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f10_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f10_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f10_mobiles_lists 
     SET secondary_camera_id = v1_secondary_camera_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f10_mobiles_lists');


     ELSE

     INSERT INTO link_f10_mobiles_lists(mobiles_list_id,
                                     secondary_camera_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_secondary_camera_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the secondary_camera_id ',v1_secondary_camera_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f11_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_processor_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_processor_id = 0 THEN
     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'No record is inserted into link_f11_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f11_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f11_mobiles_lists 
     SET processor_id = v1_processor_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f11_mobiles_lists');


     ELSE

     INSERT INTO link_f11_mobiles_lists(mobiles_list_id,
                                     processor_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_processor_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the processor_id ',v1_processor_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

     END IF;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f12_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_debugid VARCHAR(255))

     BEGIN

     DECLARE v_COUNT INT;
     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_messaging_id INT;

     SELECT COUNT(*)
     INTO quantity
     FROM features;

     DELETE FROM link_f12_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;


     carrier_loop: LOOP
     IF loopcounter <= quantity THEN

              SELECT features_id
              INTO v1_messaging_id
              FROM features
              WHERE id = loopcounter;
		
	     IF v1_messaging_id = 0 THEN
     		/* Insert a record in debug table for tracking the events */
     		 call debug.debug_insert(v1_debugid,'Record is not inserted into link_f12_mobiles_lists');

    	     ELSE

	     SELECT COUNT(*) INTO v_COUNT
	     FROM link_f12_mobiles_lists
	     WHERE mobiles_list_id = v1_mobiles_list_id AND messaging_id = v1_messaging_id;

	     IF v_COUNT = 0 THEN	
		IF v1_messaging_id IS NOT NULL THEN

		     INSERT INTO link_f12_mobiles_lists(mobiles_list_id,
                                     messaging_id,
                                     created_at)
		     values(v1_mobiles_list_id,
	        	    v1_messaging_id,
	        	    CURRENT_TIMESTAMP);

		      /* Insert a record in debug table for tracking the events */
		      call debug.debug_insert(v1_debugid,concat('A link for the messaging_id ',v1_messaging_id,' and mobiles_list_id ',v1_mobiles_list_id,
		      ' is created, about a nanosecond ago'));
 		END IF;
             ELSE
	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'No link is created in link_f12_mobiles_lists');
             END IF;
	    END IF;

     ELSE
              LEAVE carrier_loop;
     END IF;
     SET loopcounter = loopcounter + 1;
     END LOOP carrier_loop;

     drop temporary table if exists features;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f13_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;
     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_browser_id INT;

     SELECT COUNT(*)
     INTO quantity
     FROM features;

     DELETE FROM link_f13_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;


     carrier_loop: LOOP
     IF loopcounter <= quantity THEN

              SELECT features_id
              INTO v1_browser_id
              FROM features
              WHERE id = loopcounter;

	     IF v1_browser_id = 0 THEN
     		/* Insert a record in debug table for tracking the events */
     		 call debug.debug_insert(v1_debugid,'Record is not inserted into link_f13_mobiles_lists');

    	     ELSE


	     SELECT COUNT(*) INTO v_COUNT
	     FROM link_f13_mobiles_lists
	     WHERE mobiles_list_id = v1_mobiles_list_id AND browser_id = v1_browser_id;

	     IF v_COUNT = 0 THEN	
		IF v1_browser_id IS NOT NULL THEN

		     INSERT INTO link_f13_mobiles_lists(mobiles_list_id,
                                     browser_id,
                                     created_at)
		     values(v1_mobiles_list_id,
	        	    v1_browser_id,
	        	    CURRENT_TIMESTAMP);

		      /* Insert a record in debug table for tracking the events */
		      call debug.debug_insert(v1_debugid,concat('A link for the browser_id ',v1_browser_id,' and mobiles_list_id ',v1_mobiles_list_id,
		      ' is created, about a nanosecond ago'));
 		END IF;
             ELSE
	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'No link is created in link_f13_mobiles_lists');
             END IF;

	    END IF;

     ELSE
              LEAVE carrier_loop;
     END IF;
     SET loopcounter = loopcounter + 1;
     END LOOP carrier_loop;

     drop temporary table if exists features;

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f14_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_mobile_ram_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_mobile_ram_id = 0 THEN
	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v1_debugid,'Record is not inserted into link_f14_mobiles_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f14_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f14_mobiles_lists 
     SET mobile_ram_id = v1_mobile_ram_id
     WHERE mobiles_list_id = v1_mobiles_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f14_mobiles_lists');


     ELSE

     INSERT INTO link_f14_mobiles_lists(mobiles_list_id,
                                     mobile_ram_id,
                                     created_at)
     values(v1_mobiles_list_id,
            v1_mobile_ram_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobile_ram_id ',v1_mobile_ram_id,' and mobiles_list_id ',v1_mobiles_list_id,
      ' is created, about a nanosecond ago'));


     END IF;
 
    END IF;

    END;

    SQL



    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f15_mobiles_lists(IN v1_mobiles_list_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;
     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_assorteds_id INT;
     DECLARE v_assorteds VARCHAR(500);
     DECLARE v1_assorteds VARCHAR(255);

     SELECT val
     INTO v_assorteds
     FROM productfeatures
     WHERE id = 15;

     call p_Split_feature_names(v_assorteds,"assorteds");

     SELECT COUNT(*)
     INTO quantity
     FROM features;

     DELETE FROM link_f15_mobiles_lists
     WHERE mobiles_list_id = v1_mobiles_list_id;


     carrier_loop: LOOP
     IF loopcounter <= quantity THEN

	      SELECT name INTO v1_assorteds FROM features WHERE id = loopcounter;

	IF v1_assorteds = "n.a." THEN
     		/* Insert a record in debug table for tracking the events */
     		 call debug.debug_insert(v1_debugid,concat('Assorteds value ',v1_assorteds,' is not inserted into link_f15_mobiles_lists'));

	ELSE		

              SELECT assorteds_id
              INTO v1_assorteds_id
              FROM mobiles_f15_assorteds
              WHERE assorteds_name = v1_assorteds;

	     IF v1_assorteds_id = 0 THEN
     		/* Insert a record in debug table for tracking the events */
     		 call debug.debug_insert(v1_debugid,concat('Record ',v1_assorteds,' is not inserted into link_f15_mobiles_lists'));

    	     ELSE

	     SELECT COUNT(*) INTO v_COUNT
	     FROM link_f15_mobiles_lists
	     WHERE mobiles_list_id = v1_mobiles_list_id AND assorteds_id = v1_assorteds_id;

	     IF v_COUNT = 0 THEN	
		IF v1_assorteds_id IS NOT NULL THEN

		     INSERT INTO link_f15_mobiles_lists(mobiles_list_id,
                                     assorteds_id,
                                     created_at)
		     values(v1_mobiles_list_id,
	        	    v1_assorteds_id,
	        	    CURRENT_TIMESTAMP);

		      /* Insert a record in debug table for tracking the events */
		      call debug.debug_insert(v1_debugid,concat('A link for the assorteds_id ',v1_assorteds_id,' and mobiles_list_id ',v1_mobiles_list_id,
		      ' is created, about a nanosecond ago'));
 		END IF;
             ELSE
	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'No link is created in link_f15_mobiles_lists');
             END IF;
	    END IF;

	END IF;
     ELSE
              LEAVE carrier_loop;
     END IF;
     SET loopcounter = loopcounter + 1;

     END LOOP carrier_loop;

     drop temporary table if exists features;

     END;

    SQL




  end

  def down

    execute "DROP PROCEDURE p_Insert_link_f1_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f2_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f3_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f4_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f5_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f5_c_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f6_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f7_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f8_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f9_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f10_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f11_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f12_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f13_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f14_mobiles_lists"

    execute "DROP PROCEDURE p_Insert_link_f15_mobiles_lists"

  end
end


class CreateTriggerOnVendorsLists < ActiveRecord::Migration
  def up

    execute <<-SQL
    CREATE TRIGGER t_Insert_Vendors_Lists AFTER INSERT ON vendors_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_Vendors_Lists';
    DECLARE v_city_id, v_branch_id, v_count, v_fp_count, v_vp_count, v_ppc_count, v_sc_count, v_sub_category_id,
    v_subcategories_count, v_sc_check, v_fixed_flag INT;
    DECLARE loopcounter INT DEFAULT 1;
    DECLARE v_message TEXT;
    DECLARE v_subcategory VARCHAR(500);

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF LENGTH(new.vendor_sub_categories) > 0 THEN
    
	call p_Split_feature_names(new.vendor_sub_categories,"vendor_subcategories");
            
	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Procedure Split_feature_names has been called to find out the vendor sub categories ' 
	,new.vendor_sub_categories));

	SELECT COUNT(*) INTO v_sc_count FROM features;

    carrier_loop: LOOP
      IF loopcounter <= v_sc_count THEN

        SELECT name INTO v_subcategory FROM features
        WHERE id = loopcounter;

	SELECT sub_category_id INTO v_sub_category_id FROM subcategories
	WHERE sub_category_name = v_subcategory;

	IF v_sub_category_id IS NOT NULL THEN

		SELECT COUNT(*) INTO v_count FROM link_vendors_lists_sub_categories
		WHERE vendor_id = new.vendor_id AND sub_category_id = v_sub_category_id;
	
		IF v_count = 0 THEN
			
			INSERT INTO link_vendors_lists_sub_categories(vendor_id,sub_category_id,created_at)
			VALUES(new.vendor_id,v_sub_category_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
        		call debug.debug_insert(v_DebugID,concat('Link created in link_vendors_lists_sub_categories table for the vendor ',new.vendor_id));

		END IF;

	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The temporary table features is dropped successfully, about a nanosecond ago');

    DROP TEMPORARY TABLE IF EXISTS features;

    END IF;



    IF new.business_type = "local" THEN

        /* Selecting the city id and branch id from the branches table, respectively */

        SELECT branch_id,city_id INTO v_branch_id,v_city_id FROM branches
        WHERE f_stripstring(branch_name) = f_stripstring(new.branch_name);

            /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are ',v_city_id,' ',v_branch_id));


            IF v_city_id IS NOT NULL AND v_branch_id IS NOT NULL THEN

	              INSERT INTO link_vendors_lists_cities(city_id, vendor_id, created_at)
	              VALUES(v_city_id, new.vendor_id, now());

	              INSERT INTO link_vendors_lists_branches(branch_id, vendor_id, created_at)
	              VALUES(v_branch_id, new.vendor_id, now());

                      /* Insert a record in debug table for tracking the events */
                  call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are inserted into the links tables for local vendor ',new.vendor_name));

            ELSE

                SET v_message = "The city_id or branch_id is missing";

                call p_Insert_priority_errors(new.business_type,new.vendor_name,new.city_name,new.branch_name,v_message,v_fixed_flag,v_DebugID);


                /* Insert a record in debug table for tracking the events */
            call debug.debug_insert(v_DebugID,'The city_id or branch_id is missing, priority error message set');

            END IF;

    END IF;



    SELECT count(*) INTO v_fp_count FROM fixed_pay_vendors
    WHERE vendor_id = new.vendor_id;

    SELECT count(*) INTO v_vp_count FROM variable_pay_vendors
    WHERE vendor_id = new.vendor_id;

    SELECT count(*) INTO v_ppc_count FROM product_purchase_commission_vendors
    WHERE vendor_id = new.vendor_id;

    IF new.monetization_type IS NOT NULL AND new.subscribed_date IS NOT NULL THEN

	IF new.monetization_type = "fixed" THEN

		IF v_fp_count = 1 THEN

		UPDATE fixed_pay_vendors SET history_flag = 0, accepted_amount=0, subscribed_date = new.subscribed_date, 
		cut_off_period = 0, created_at = now(), updated_at = NULL
		WHERE vendor_id = new.vendor_id;
	
		/* Insert a record in debug table for tracking the events */
	        call debug.debug_insert(v_DebugID,concat('Record created for the new vendor ',new.vendor_name,' ',new.vendor_id,' in fixed pay vendors table'));

		ELSE
		
		INSERT INTO fixed_pay_vendors(vendor_id,accepted_amount,subscribed_date,cut_off_period,created_at)
		VALUES(new.vendor_id,0,new.subscribed_date,0,now());

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Inserted a record for vendor ',new.vendor_name,' ',new.vendor_id,' into fixed pay vendors table'));

		END IF;

	ELSEIF new.monetization_type = "variable" THEN

    		IF v_vp_count = 1 THEN

		UPDATE variable_pay_vendors SET history_flag = 0, accepted_impressions_rate = 0, accepted_button_click_rate = 0,
		subscribed_date = new.subscribed_date, cut_off_amount = 0, cut_off_period = 0, created_at = now(), updated_at = NULL
		WHERE vendor_id = new.vendor_id;

		/* Insert a record in debug table for tracking the events */
        	call debug.debug_insert(v_DebugID,concat('Record created for the new vendor ',new.vendor_name,' ',new.vendor_id,' in variable pay vendors table'));

		ELSE
		
		INSERT INTO variable_pay_vendors(vendor_id, accepted_impressions_rate, accepted_button_click_rate, subscribed_date, cut_off_amount, 
		cut_off_period, created_at)
		VALUES(new.vendor_id,0,0,new.subscribed_date,0,0,now());

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Inserted a record for vendor ',new.vendor_name,' ',new.vendor_id,' into variable pay vendors table'));

    		END IF;



		DELETE FROM product_purchase_commission_vendors WHERE vendor_id = new.vendor_id;

		SELECT MAX(sub_category_id) INTO v_subcategories_count FROM subcategories;

		SET loopcounter = 1;

	        carrier_loop: LOOP
		 IF loopcounter <= v_subcategories_count THEN

			SELECT COUNT(*) INTO v_sc_check FROM link_vendors_lists_sub_categories
			WHERE vendor_id = new.vendor_id AND sub_category_id = loopcounter;
		
			IF v_sc_check = 1 THEN

				INSERT INTO product_purchase_commission_vendors(vendor_id, sub_category_id, purchase_commission, subscribed_date, 					cut_off_amount, cut_off_period, history_flag, created_at)
				VALUES(new.vendor_id,loopcounter,0,new.subscribed_date,0,0,0,now());

			END IF;	

		 ELSE
		 	LEAVE carrier_loop;
		 END IF;
		 	SET loopcounter = loopcounter + 1;
		END LOOP carrier_loop;

		/* Insert a record in debug table for tracking the events */
        	call debug.debug_insert(v_DebugID,concat('Records created for the new vendor ',new.vendor_name,' ',new.vendor_id,' in product purchase commission 			vendors table'));

	ELSEIF new.monetization_type = "purchase" THEN

		DELETE FROM product_purchase_commission_vendors WHERE vendor_id = new.vendor_id;

		SELECT MAX(sub_category_id) INTO v_subcategories_count FROM subcategories;

		SET loopcounter = 1;

	        carrier_loop: LOOP
		 IF loopcounter <= v_subcategories_count THEN

			SELECT COUNT(*) INTO v_sc_check FROM link_vendors_lists_sub_categories
			WHERE vendor_id = new.vendor_id AND sub_category_id = loopcounter;
		
			IF v_sc_check = 1 THEN

				INSERT INTO product_purchase_commission_vendors(vendor_id, sub_category_id, purchase_commission, subscribed_date, 					cut_off_amount, cut_off_period, history_flag, created_at)
				VALUES(new.vendor_id,loopcounter,0,new.subscribed_date,0,0,0,now());

			END IF;	

		 ELSE
		 	LEAVE carrier_loop;
		 END IF;
		 	SET loopcounter = loopcounter + 1;
		END LOOP carrier_loop;

		/* Insert a record in debug table for tracking the events */
        	call debug.debug_insert(v_DebugID,concat('Records created for the new vendor ',new.vendor_name,' ',new.vendor_id,' in product purchase commission 			vendors table'));


	END IF;

    END IF;
   

 /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Vendors_Lists AFTER UPDATE ON vendors_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Update_Vendors_Lists';
    DECLARE v_city_id_new, v_city_id_old, v_branch_id_new, v_branch_id_old, v_id, v_fp_count, v_vp_count, v_sc_count,
    v_sub_category_id, v_count, v_ppc_count, v_subcategories_count, v_sc_check, v_fixed_flag INT;
    DECLARE loopcounter INT DEFAULT 1;
    DECLARE v_message TEXT;
    DECLARE v_subcategory VARCHAR(500);
    DECLARE v_subcategories_id VARCHAR(255) DEFAULT ' ';

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);


    IF LENGTH(new.vendor_sub_categories) > 0 THEN
    
	call p_Split_feature_names(new.vendor_sub_categories,"vendor_subcategories");
            
	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Procedure Split_feature_names has been called to find out the vendor sub categories '
	,new.vendor_sub_categories));

	SELECT COUNT(*) INTO v_sc_count FROM features;

	DELETE FROM link_vendors_lists_sub_categories WHERE vendor_id = old.vendor_id;

    carrier_loop: LOOP
      IF loopcounter <= v_sc_count THEN

        SELECT name INTO v_subcategory FROM features
        WHERE id = loopcounter;

	SELECT sub_category_id INTO v_sub_category_id FROM subcategories
	WHERE sub_category_name = v_subcategory;


	IF v_sub_category_id IS NOT NULL THEN

		SELECT COUNT(*) INTO v_count FROM link_vendors_lists_sub_categories
		WHERE vendor_id = old.vendor_id AND sub_category_id = v_sub_category_id;
	
		IF v_count = 0 THEN
			
			INSERT INTO link_vendors_lists_sub_categories(vendor_id,sub_category_id,created_at)
			VALUES(old.vendor_id,v_sub_category_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
        		call debug.debug_insert(v_DebugID,concat('Link created in link_vendors_lists_sub_categories table for the vendor ',old.vendor_id));

		END IF;

	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
	SET loopcounter = loopcounter + 1;
	
    END LOOP carrier_loop;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The temporary table features is dropped successfully, about a nanosecond ago');

    DROP TEMPORARY TABLE IF EXISTS features;

    END IF;



    IF new.business_type = "local" THEN

    /* Selecting the city id and branch id from the cities and branches table, respectively */


    SELECT branch_id,city_id INTO v_branch_id_new,v_city_id_new FROM branches
    WHERE f_stripstring(branch_name) = f_stripstring(new.branch_name);

    SELECT branch_id,city_id INTO v_branch_id_old,v_city_id_old FROM branches
    WHERE f_stripstring(branch_name) = f_stripstring(old.branch_name);

        /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are ',v_city_id_new,' ',v_branch_id_new));


          IF v_city_id_new IS NOT NULL AND v_branch_id_new IS NOT NULL THEN

	              SELECT id INTO v_id FROM link_vendors_lists_cities
	              WHERE vendor_id = new.vendor_id AND city_id = v_city_id_old;

	              UPDATE link_vendors_lists_cities SET city_id = v_city_id_new, updated_at = now()
	              WHERE id = v_id;

	              SELECT id INTO v_id FROM link_vendors_lists_branches
	              WHERE vendor_id = new.vendor_id AND branch_id = v_branch_id_old;

	              UPDATE link_vendors_lists_branches SET branch_id = v_branch_id_new, updated_at = now()
	              WHERE id = v_id;

                      /* Insert a record in debug table for tracking the events */
                  call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are updated into the links tables for local vendor ',new.vendor_name));

          ELSE

              SET v_message = "The updated city_id or branch_id is missing";

              call p_Insert_priority_errors(new.business_type,new.vendor_name,new.city_name,new.branch_name,v_message,v_fixed_flag,v_DebugID);

	            DELETE FROM link_vendors_lists_cities WHERE city_id = v_city_id_old;

	            DELETE FROM link_vendors_lists_branches WHERE branch_id = v_branch_id_old;


              /* Insert a record in debug table for tracking the events */
          call debug.debug_insert(v_DebugID,'The updated city_id or branch_id is missing, priority error message set');

          END IF;

    END IF;



    IF new.monetization_type IS NOT NULL AND new.subscribed_date IS NOT NULL THEN

	IF new.monetization_type = "fixed" THEN
		SELECT COUNT(*) INTO v_fp_count FROM fixed_pay_vendors
		WHERE vendor_id = old.vendor_id;

		SELECT COUNT(*) INTO v_vp_count FROM variable_pay_vendors
		WHERE vendor_id = old.vendor_id;

		SELECT count(*) INTO v_ppc_count FROM product_purchase_commission_vendors
		WHERE vendor_id = new.vendor_id;
		
		IF v_fp_count = 0 THEN
		
		INSERT INTO fixed_pay_vendors(vendor_id,accepted_amount,subscribed_date,cut_off_period,created_at)
		VALUES(old.vendor_id,0,new.subscribed_date,0,now());

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Inserted a record for vendor ',old.vendor_name,' ',old.vendor_id,' into fixed pay vendors table'));

		IF v_vp_count = 1 THEN

		UPDATE variable_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in variable pay vendors table'));

		END IF;

		IF v_ppc_count > 0 THEN

		UPDATE product_purchase_commission_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in product_purchase_commission_vendors table'));

		END IF;

		ELSE

		UPDATE fixed_pay_vendors SET subscribed_date = new.subscribed_date,accepted_amount=0,
		cut_off_period=0,history_flag = 0,updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Updated the subscribed date value in fixed pay vendors table for vendor_id ',old.vendor_id));

		IF v_vp_count = 1 THEN

		UPDATE variable_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in variable pay vendors table'));

		END IF;

		IF v_ppc_count > 0 THEN

		UPDATE product_purchase_commission_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in product_purchase_commission_vendors table'));

		END IF;

		END IF;

	ELSEIF new.monetization_type = "variable" THEN

		SELECT COUNT(*) INTO v_vp_count FROM variable_pay_vendors
		WHERE vendor_id = old.vendor_id;

		SELECT COUNT(*) INTO v_fp_count FROM fixed_pay_vendors
		WHERE vendor_id = old.vendor_id;

		SELECT count(*) INTO v_ppc_count FROM product_purchase_commission_vendors
		WHERE vendor_id = new.vendor_id;
		
		IF v_vp_count = 0 THEN
		
		INSERT INTO variable_pay_vendors(vendor_id, accepted_impressions_rate, accepted_button_click_rate, subscribed_date, 
		cut_off_amount, cut_off_period, created_at)
		VALUES(old.vendor_id,0,0,new.subscribed_date,0,0,now());

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Inserted a record for vendor ',old.vendor_name,' ',old.vendor_id,' into variable pay vendors table'));


		IF v_fp_count = 1 THEN

		UPDATE fixed_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in fixed pay vendors table'));

		END IF;

		ELSE

		UPDATE variable_pay_vendors SET subscribed_date = new.subscribed_date,accepted_impressions_rate = 0,
		accepted_button_click_rate = 0,cut_off_amount = 0,cut_off_period = 0,history_flag = 0,updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Updated the subscribed date value in variable pay vendors table for vendor_id ',old.vendor_id));

		IF v_fp_count = 1 THEN

		UPDATE fixed_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in fixed pay vendors table'));

		END IF;

		END IF;

		DELETE FROM product_purchase_commission_vendors WHERE vendor_id = old.vendor_id;

		SELECT MAX(sub_category_id) INTO v_subcategories_count FROM subcategories;

		SET loopcounter = 1;

	        carrier_loop: LOOP
		 IF loopcounter <= v_subcategories_count THEN

			SELECT COUNT(*) INTO v_sc_check FROM link_vendors_lists_sub_categories
			WHERE vendor_id = new.vendor_id AND sub_category_id = loopcounter;
		
			IF v_sc_check = 1 THEN

				INSERT INTO product_purchase_commission_vendors(vendor_id, sub_category_id, purchase_commission, subscribed_date, 					cut_off_amount, cut_off_period, history_flag, created_at)
				VALUES(old.vendor_id,loopcounter,0,new.subscribed_date,0,0,0,now());

			/* Insert a record in debug table for tracking the events */
	                call debug.debug_insert(v_DebugID,concat('Record created for the vendor ',old.vendor_name,' ',old.vendor_id,' in product purchase commission vendors table for subcategory ',loopcounter));

			END IF;	

		 ELSE
		 	LEAVE carrier_loop;
		 END IF;
		 	SET loopcounter = loopcounter + 1;
		END LOOP carrier_loop;

		/* Insert a record in debug table for tracking the events */
        	call debug.debug_insert(v_DebugID,concat('Records created for the new vendor ',old.vendor_name,' ',old.vendor_id,' in product purchase commission 			vendors table'));

	ELSEIF new.monetization_type = "purchase" THEN

		DELETE FROM product_purchase_commission_vendors WHERE vendor_id = old.vendor_id;

		SELECT MAX(sub_category_id) INTO v_subcategories_count FROM subcategories;

		SET loopcounter = 1;

	        carrier_loop: LOOP
		 IF loopcounter <= v_subcategories_count THEN

			SELECT COUNT(*) INTO v_sc_check FROM link_vendors_lists_sub_categories
			WHERE vendor_id = new.vendor_id AND sub_category_id = loopcounter;
		
			IF v_sc_check = 1 THEN

				INSERT INTO product_purchase_commission_vendors(vendor_id, sub_category_id, purchase_commission, subscribed_date, 					cut_off_amount, cut_off_period, history_flag, created_at)
				VALUES(old.vendor_id,loopcounter,0,new.subscribed_date,0,0,0,now());

			END IF;	

		 ELSE
		 	LEAVE carrier_loop;
		 END IF;
		 	SET loopcounter = loopcounter + 1;
		END LOOP carrier_loop;

		/* Insert a record in debug table for tracking the events */
        	call debug.debug_insert(v_DebugID,concat('Records created for the new vendor ',old.vendor_name,' ',old.vendor_id,' in product purchase commission 			vendors table'));


		SELECT COUNT(*) INTO v_vp_count FROM variable_pay_vendors
		WHERE vendor_id = old.vendor_id;

		SELECT COUNT(*) INTO v_fp_count FROM fixed_pay_vendors
		WHERE vendor_id = old.vendor_id;

		IF v_fp_count = 1 THEN

		UPDATE fixed_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in fixed pay vendors table'));

		END IF;

		IF v_vp_count = 1 THEN

		UPDATE variable_pay_vendors SET history_flag = 1, updated_at = now()
		WHERE vendor_id = old.vendor_id;

		/* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('Changed the history_flag of vendor ',old.vendor_name,' ',old.vendor_id,' in variable pay vendors table'));

		END IF;

	END IF;

    END IF;


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_Vendors_Lists BEFORE DELETE ON vendors_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Delete_Vendors_Lists';
    DECLARE v_city_id, v_branch_id, v_id, v_fp_count, v_vp_count, v_ppc_count INT;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);


    DELETE FROM link_vendors_lists_sub_categories WHERE vendor_id = old.vendor_id;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Links in link_vendors_lists_sub_categories have been cleared for the deleted vendor_id ',old.vendor_id));



    IF old.business_type = "local" THEN

        /* Selecting the city id and branch id from the cities and branches table, respectively */

        SELECT branch_id,city_id INTO v_branch_id,v_city_id FROM branches
        WHERE f_stripstring(branch_name) = f_stripstring(old.branch_name);

            /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are ',v_city_id,' ',v_branch_id));

          IF v_city_id IS NOT NULL AND v_branch_id IS NOT NULL THEN

	            SELECT id INTO v_id FROM link_vendors_lists_cities
	            WHERE vendor_id = old.vendor_id AND city_id = v_city_id;

	            DELETE FROM link_vendors_lists_cities WHERE id = v_id;

	            SELECT id INTO v_id FROM link_vendors_lists_branches
	            WHERE vendor_id = old.vendor_id AND branch_id = v_branch_id;

	            DELETE FROM link_vendors_lists_branches WHERE id = v_id;

                    /* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v_DebugID,concat('The city_id and branch_id are deleted from the links tables for local vendor ',old.vendor_name));

            END IF;

    END IF;



    SELECT count(*) INTO v_fp_count FROM fixed_pay_vendors
    WHERE vendor_id = old.vendor_id;

    SELECT count(*) INTO v_vp_count FROM variable_pay_vendors
    WHERE vendor_id = old.vendor_id;

    SELECT count(*) INTO v_ppc_count FROM product_purchase_commission_vendors
    WHERE vendor_id = old.vendor_id;

    IF v_fp_count = 1 THEN

	UPDATE fixed_pay_vendors SET history_flag = 1, updated_at = now()
	WHERE vendor_id = old.vendor_id;

	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Details of the vendor ',old.vendor_name,' ',old.vendor_id,' in fixed pay vendors table has been made a history'));

    END IF;

    IF v_vp_count = 1 THEN

	UPDATE variable_pay_vendors SET history_flag = 1, updated_at = now()
	WHERE vendor_id = old.vendor_id;

	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Details of the vendor ',old.vendor_name,' ',old.vendor_id,' in variavb pay vendors table has been made a history'));

    END IF;

    IF v_ppc_count = 1 THEN

	UPDATE product_purchase_commission_vendors SET history_flag = 1, updated_at = now()
	WHERE vendor_id = old.vendor_id;

	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Details of the vendor ',old.vendor_name,' ',old.vendor_id,' in product_purchase_commission_vendors table have been made a history'));

    END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL


  end

  def down


    execute "DROP TRIGGER IF EXISTS t_Insert_Vendors_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Vendors_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Vendors_Lists"


  end
end


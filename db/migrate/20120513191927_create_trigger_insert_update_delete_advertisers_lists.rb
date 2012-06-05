class CreateTriggerInsertUpdateDeleteAdvertisersLists < ActiveRecord::Migration
  def up

    execute <<-SQL
    CREATE TRIGGER t_Insert_advertisers_Lists AFTER INSERT ON advertisers_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_Adverisers_Lists';
    DECLARE v_sc_count, v_sub_category_id, v_count INT;
    DECLARE loopcounter INT DEFAULT 1;
    DECLARE v_subcategory VARCHAR(255);

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF LENGTH(new.advertiser_sub_categories) > 0 THEN
    
	call p_Split_feature_names(new.advertiser_sub_categories,"advertiser_subcategories");
            
	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Procedure Split_feature_names has been called to find out the advertiser sub categories ' 
	,new.advertiser_sub_categories));

	SELECT COUNT(*) INTO v_sc_count FROM features;

    carrier_loop: LOOP
      IF loopcounter <= v_sc_count THEN

        SELECT name INTO v_subcategory FROM features
        WHERE id = loopcounter;

	SELECT sub_category_id INTO v_sub_category_id FROM subcategories
	WHERE sub_category_name = v_subcategory;

	IF v_sub_category_id IS NOT NULL THEN

		SELECT COUNT(*) INTO v_count FROM link_advertisers_lists_sub_categories
		WHERE advertiser_id = new.advertiser_id AND sub_category_id = v_sub_category_id;
	
		IF v_count = 0 THEN
			
			INSERT INTO link_advertisers_lists_sub_categories(advertiser_id,sub_category_id,created_at)
			VALUES(new.advertiser_id,v_sub_category_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
        		call debug.debug_insert(v_DebugID,concat('Link created in link_advertisers_lists_sub_categories table for the advertiser ',new.advertiser_id));

			INSERT INTO ad_lists(advertiser_id, sub_category_id, subscribed_date, created_at)
			VALUES(new.advertiser_id, v_sub_category_id, new.subscribed_date, CURRENT_TIMESTAMP);

		END IF;

	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;


    END IF;

  /*added by senthil on 2012may16 to drop the feature temporary table*/
    IF f_flushfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The temporary table features is dropped successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The features temporary table is not dropped successfully');

    END IF;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_advertisers_Lists AFTER UPDATE ON advertisers_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Update_Adverisers_Lists';
    DECLARE v_sc_count, v_sub_category_id, v_count INT;
    DECLARE loopcounter INT DEFAULT 1;
    DECLARE v_subcategory VARCHAR(255);

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF LENGTH(new.advertiser_sub_categories) > 0 THEN
    
	call p_Split_feature_names(new.advertiser_sub_categories,"advertiser_subcategories");
            
	/* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v_DebugID,concat('Procedure Split_feature_names has been called to find out the advertiser sub categories ' 
	,new.advertiser_sub_categories));

	SELECT COUNT(*) INTO v_sc_count FROM features;

	DELETE FROM link_advertisers_lists_sub_categories WHERE advertiser_id = old.advertiser_id AND
	sub_category_id NOT IN (SELECT sub_category_id FROM subcategories WHERE sub_category_name IN (SELECT name FROM features));

	DELETE FROM ad_lists WHERE advertiser_id = old.advertiser_id AND
	sub_category_id NOT IN (SELECT sub_category_id FROM subcategories WHERE sub_category_name IN (SELECT name FROM features));

    carrier_loop: LOOP
      IF loopcounter <= v_sc_count THEN

        SELECT name INTO v_subcategory FROM features
        WHERE id = loopcounter;

	SELECT sub_category_id INTO v_sub_category_id FROM subcategories
	WHERE sub_category_name = v_subcategory;

	IF v_sub_category_id IS NOT NULL THEN

		SELECT COUNT(*) INTO v_count FROM link_advertisers_lists_sub_categories
		WHERE advertiser_id = old.advertiser_id AND sub_category_id = v_sub_category_id;
	
		IF v_count = 0 THEN
			
			INSERT INTO link_advertisers_lists_sub_categories(advertiser_id,sub_category_id,created_at)
			VALUES(new.advertiser_id,v_sub_category_id,CURRENT_TIMESTAMP);

			/* Insert a record in debug table for tracking the events */
        		call debug.debug_insert(v_DebugID,concat('Link created in link_advertisers_lists_sub_categories table for the advertiser ',new.advertiser_id));

			INSERT INTO ad_lists(advertiser_id, sub_category_id, subscribed_date, created_at)
			VALUES(new.advertiser_id, v_sub_category_id, new.subscribed_date, CURRENT_TIMESTAMP);

		END IF;

	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;


    END IF;
 /*added by senthil on 2012may16 to drop the feature temporary table*/
    IF f_flushfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The temporary table features is dropped successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The features temporary table is not dropped successfully');

    END IF;
    


/* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_advertisers_Lists AFTER DELETE ON advertisers_lists
    FOR EACH ROW
    BEGIN

    DELETE FROM link_advertisers_lists_sub_categories WHERE advertiser_id = old.advertiser_id;

    DELETE FROM ad_lists WHERE advertiser_id = old.advertiser_id;
    
    END
    SQL
  end

  def down
    execute "DROP TRIGGER t_Insert_advertisers_Lists"
    execute "DROP TRIGGER t_Update_advertisers_Lists"
    execute "DROP TRIGGER t_Delete_advertisers_Lists"
  end
end

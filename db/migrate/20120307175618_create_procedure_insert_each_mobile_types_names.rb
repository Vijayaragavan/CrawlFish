class CreateProcedureInsertEachMobileTypesNames < ActiveRecord::Migration
   def up

   execute <<-SQL
    CREATE PROCEDURE p_Insert_each_mobile_types_names(IN v1_debugid VARCHAR(255))
    BEGIN

    DECLARE v_count INT Default 0;
    DECLARE loopcounter INT Default 1;
    DECLARE v_currentName VARCHAR(255);
    DECLARE v_mobile_type_id INT;
    DECLARE v_countMobileTypesNames INT Default 0;
    DECLARE v_trimCurrentName VARCHAR(255);

    SELECT COUNT(*) INTO v_count
    FROM features;

    carrier_loop: LOOP
      IF loopcounter <= v_count THEN

         SELECT name INTO v_currentName
         FROM features
         WHERE id = loopcounter;

	IF lower(v_currentName) = "n.a." THEN
	/* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A mobile type name is not a valid one. Mobile type name is not inserted into mobiles_f3_mobile_types, about a nanosecond ago');

	UPDATE features
        SET features_id = 0
        WHERE f_stripstring(name)= f_stripstring(v_currentName);

	ELSE

         SET v_trimCurrentName = LTRIM(RTRIM(v_currentName));

        SELECT COUNT(*) INTO v_countMobileTypesNames
         FROM mobiles_f3_mobile_types
         WHERE f_stripstring(mobile_type_name) = f_stripstring(v_trimCurrentName);

         IF v_countMobileTypesNames = 0 THEN


         INSERT INTO mobiles_f3_mobile_types (mobile_type_name,
                                       created_at)
         VALUES (v_trimCurrentName,
                 CURRENT_TIMESTAMP);

         SELECT mobile_type_id
         INTO v_mobile_type_id
         FROM mobiles_f3_mobile_types
         WHERE f_stripstring(mobile_type_name)= f_stripstring(v_trimCurrentName);

        UPDATE features
        SET features_id = v_mobile_type_id
        WHERE f_stripstring(name)= f_stripstring(v_trimCurrentName);

	
	      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A mobile type name is inserted into mobiles_f3_mobile_types, about a nanosecond ago');


  
         ELSE

         SELECT mobile_type_id
         INTO v_mobile_type_id
         FROM mobiles_f3_mobile_types
         WHERE f_stripstring(mobile_type_name)= f_stripstring(v_trimCurrentName);

        UPDATE features
        SET features_id = v_mobile_type_id
        WHERE f_stripstring(name)= f_stripstring(v_trimCurrentName);

	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,'The mobile type name already exists so, the insert is aborted');



         END IF;

	END IF;
   
     ELSE
              LEAVE carrier_loop;
  
    END IF;

      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;



     END;

    SQL


  end

  def down

     execute "DROP PROCEDURE p_Insert_each_mobile_types_names"

  end
end


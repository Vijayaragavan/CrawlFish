class CreateProcedureInsertEachGenreNames < ActiveRecord::Migration
   def up

   execute <<-SQL
    CREATE PROCEDURE p_Insert_each_genre_names(IN v1_sub_category_id INT,
                                               IN v1_debugid VARCHAR(255))
    BEGIN

    DECLARE v_count, v_countGenreNames, v_level_id INT Default 0;
    DECLARE loopcounter INT Default 1;
    DECLARE v_trimCurrentName, v_currentName VARCHAR(255);
    DECLARE v_genre_id INT;


    SELECT COUNT(*) INTO v_count
    FROM features;

	carrier_loop: LOOP
	IF loopcounter <= v_count THEN

		SELECT name INTO v_currentName
		FROM features
		WHERE id = loopcounter;

		IF LOWER(SUBSTRING_INDEX(v_currentName,"$",1)) = "n.a." THEN

			SELECT 0 INTO v_genre_id;

		ELSE

			SET v_currentName = LTRIM(RTRIM(v_currentName));
			SET v_trimCurrentName = SUBSTRING_INDEX(v_currentName,"$",1);
			SET v_level_id = SUBSTRING_INDEX(v_currentName,"$",-1);

			IF v_trimCurrentName != "books" THEN

				SELECT COUNT(*) INTO v_countGenreNames FROM books_f2_genres
				WHERE (f_stripstring(genre_name),level_id) = (f_stripstring(v_trimCurrentName),v_level_id);

				IF v_countGenreNames = 0 THEN


					INSERT INTO books_f2_genres (genre_name,level_id,created_at)
					VALUES (v_trimCurrentName,v_level_id,CURRENT_TIMESTAMP);

					SELECT genre_id INTO v_genre_id FROM books_f2_genres
					WHERE (f_stripstring(genre_name),level_id)= (f_stripstring(v_trimCurrentName),v_level_id);

					UPDATE features SET features_id = v_genre_id
				        WHERE f_stripstring(name)= f_stripstring(v_currentName);


				ELSE

				        SELECT genre_id INTO v_genre_id FROM books_f2_genres
					WHERE (f_stripstring(genre_name),level_id) = (f_stripstring(v_trimCurrentName),v_level_id);

					UPDATE features SET features_id = v_genre_id
					WHERE f_stripstring(name)= f_stripstring(v_currentName);

				END IF;

			ELSE
				SELECT 0 INTO v_genre_id;

				UPDATE features SET features_id = v_genre_id
				WHERE f_stripstring(name)= f_stripstring(v_currentName);

			END IF;

     			UPDATE features SET features_id = v_genre_id
		        WHERE f_stripstring(name)= f_stripstring(v_currentName);

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

     execute "DROP PROCEDURE p_Insert_each_genre_names"

  end
end


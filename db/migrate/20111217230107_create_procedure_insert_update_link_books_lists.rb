class CreateProcedureInsertUpdateLinkBooksLists < ActiveRecord::Migration
  def up


    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f1_books_lists(IN v1_books_list_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN



     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_author_id INT;
     DECLARE v_Count INT Default 0;


    SELECT COUNT(*)
    INTO quantity
    FROM features;

     DELETE FROM link_f1_books_lists
     WHERE books_list_id = v1_books_list_id;

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SELECT features_id
              INTO v1_author_id
              FROM features
              WHERE id = loopcounter;

	IF v1_author_id = 0 THEN
	  /* Insert a record in debug table for tracking the events */
                 call debug.debug_insert(v1_debugid,'No link is created in link_f1_books_lists');

	ELSE

              SELECT COUNT(*) INTO v_Count
              FROM link_f1_books_lists
              WHERE books_list_id = v1_books_list_id AND author_id = v1_author_id;

              IF v_Count = 0 THEN
                 IF v1_author_id IS NOT NULL THEN

                     INSERT INTO link_f1_books_lists( books_list_id,
                                                      author_id,
                                                      created_at)
                     values(v1_books_list_id,
                            v1_author_id,
                            CURRENT_TIMESTAMP);
                         /* Insert a record in debug table for tracking the events */
                         call debug.debug_insert(v1_debugid,concat('A link for the author_id ',v1_author_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));
                  ELSE

                         /* Insert a record in debug table for tracking the events */
                        call debug.debug_insert(v1_debugid,'No link is created in link_f1_books_lists');
                  END IF;
             END IF;

	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    DROP TEMPORARY TABLE features;

    END;
     SQL

     execute <<-SQL
     CREATE PROCEDURE p_Insert_link_f2_books_lists(IN v1_books_list_id INT,
                                                   IN v1_debugid VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;
     DECLARE loopcounter INT Default 1;
     DECLARE quantity INT Default 0;
     DECLARE v1_genre_id INT;
     DECLARE v1_genre VARCHAR(255);


    SELECT COUNT(*)
    INTO quantity
    FROM features;

     DELETE FROM link_f2_books_lists
     WHERE books_list_id = v1_books_list_id;

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SELECT features_id,name
              INTO v1_genre_id,v1_genre
              FROM features
              WHERE id = loopcounter;

	IF v1_genre_id = 0 THEN
	   /* Insert a record in debug table for tracking the events */
                  call debug.debug_insert(v1_debugid,concat('No link is created in link_f2_books_lists for the genre ',v1_genre));

	ELSE

              SELECT COUNT(*) INTO v_COUNT
              FROM link_f2_books_lists
              WHERE books_list_id = v1_books_list_id AND genre_id = v1_genre_id;

              IF v_COUNT = 0 THEN

                  IF v1_genre_id IS NOT NULL THEN

                  INSERT INTO link_f2_books_lists( books_list_id,
                                                   genre_id,
                                                   created_at)
                  values(v1_books_list_id,
                         v1_genre_id,
                         CURRENT_TIMESTAMP);

                   /* Insert a record in debug table for tracking the events */
                  call debug.debug_insert(v1_debugid,concat('A link for the genre_id ',v1_genre_id,' and books_list_id ',v1_books_list_id,
      ' is created, INSIDE A LOOP, about a nanosecond ago'));
                   END IF;
              ELSE

                /* Insert a record in debug table for tracking the events */
                call debug.debug_insert(v1_debugid,concat('No link is created in link_f2_books_lists for the genre ',v1_genre,' and genre id ',v1_genre_id));

              END IF;
	END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    DROP TEMPORARY TABLE features;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f3_books_lists(IN v1_books_list_id INT,
                                                  IN v1_isbn_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;

     SELECT COUNT(*) INTO v_COUNT FROM link_f3_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f3_books_lists 
     SET isbn_id = v1_isbn_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f3_books_lists');


     ELSE

     INSERT INTO link_f3_books_lists(books_list_id,
                                     isbn_id,
                                     created_at)
     values(v1_books_list_id,
            v1_isbn_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the isbn_id ',v1_isbn_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;


    END;
   SQL

   execute <<-SQL
   CREATE PROCEDURE p_Insert_link_f4_books_lists(IN v1_books_list_id INT,
                                                  IN v1_isbn13_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     SELECT COUNT(*) INTO v_COUNT FROM link_f4_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f4_books_lists 
     SET isbn13_id = v1_isbn13_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f4_books_lists');


     ELSE

     INSERT INTO link_f4_books_lists(books_list_id,
                                     isbn13_id,
                                     created_at)
     values(v1_books_list_id,
            v1_isbn13_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the isbn13_id ',v1_isbn13_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;


    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f5_books_lists(IN v1_books_list_id INT,
                                                  IN v1_binding_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_binding_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f5_books_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f5_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f5_books_lists 
     SET binding_id = v1_binding_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f5_books_lists');


     ELSE

     INSERT INTO link_f5_books_lists(books_list_id,
                                     binding_id,
                                     created_at)
     values(v1_books_list_id,
            v1_binding_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the binding_id ',v1_binding_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f6_books_lists(IN v1_books_list_id INT,
                                                  IN v1_publishing_date_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_publishing_date_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f6_books_lists');

     ELSE


     SELECT COUNT(*) INTO v_COUNT FROM link_f6_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f6_books_lists 
     SET publishing_date_id = v1_publishing_date_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f6_books_lists');


     ELSE

     INSERT INTO link_f6_books_lists(books_list_id,
                                     publishing_date_id,
                                     created_at)
     values(v1_books_list_id,
            v1_publishing_date_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the publishing_date_id ',v1_publishing_date_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f7_books_lists(IN v1_books_list_id INT,
                                                  IN v1_publisher_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_publisher_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f7_books_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f7_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f7_books_lists 
     SET publisher_id = v1_publisher_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f7_books_lists');


     ELSE

     INSERT INTO link_f7_books_lists(books_list_id,
                                     publisher_id,
                                     created_at)
     values(v1_books_list_id,
            v1_publisher_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the publisher_id ',v1_publisher_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f8_books_lists(IN v1_books_list_id INT,
                                                  IN v1_edition_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_edition_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f8_books_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f8_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f8_books_lists 
     SET edition_id = v1_edition_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f8_books_lists');


     ELSE

     INSERT INTO link_f8_books_lists(books_list_id,
                                     edition_id,
                                     created_at)
     values(v1_books_list_id,
            v1_edition_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the edition_id ',v1_edition_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f9_books_lists(IN v1_books_list_id INT,
                                                  IN v1_language_id INT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_language_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f9_books_lists');

     ELSE

     SELECT COUNT(*) INTO v_COUNT FROM link_f9_books_lists
     WHERE books_list_id = v1_books_list_id;

     IF v_COUNT > 0 THEN

     UPDATE link_f9_books_lists 
     SET language_id = v1_language_id
     WHERE books_list_id = v1_books_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f9_books_lists');


     ELSE

     INSERT INTO link_f9_books_lists(books_list_id,
                                     language_id,
                                     created_at)
     values(v1_books_list_id,
            v1_language_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the language_id ',v1_language_id,' and books_list_id ',v1_books_list_id,
      ' is created, about a nanosecond ago'));


     END IF;

    END IF;

    END;
   SQL


  end

  def down

    execute "DROP PROCEDURE p_Insert_link_f1_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f2_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f3_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f4_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f5_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f6_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f7_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f8_books_lists"

    execute "DROP PROCEDURE p_Insert_link_f9_books_lists"

  end
end


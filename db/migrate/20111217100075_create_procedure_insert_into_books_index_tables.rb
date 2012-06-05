class CreateProcedureInsertIntoBooksIndexTables < ActiveRecord::Migration
  def up

 
    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f1_authors( IN v1_sub_category_id INT,
                                                IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_AuthorName VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;
     DECLARE v1_author_id INT;


     SELECT val
     INTO v_AuthorName
     FROM productfeatures
     WHERE id = 1;


     call p_Split_feature_names(v_AuthorName,"author");

      call debug.debug_insert(v1_debugid,'Features table is created, about a nanosecond ago');

     call p_Insert_each_author_names(v1_sub_category_id,
                                              v1_debugid);


     /* calling insert into filters collections is moved into insert author names in parts procedure, because a book can have 3 mor more authors and the for loop that iterates through all those authors are in the scope of the parts procedure mentioned above. */

     END;
     SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f2_genres(IN v1_sub_category_id INT,
                                              IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_genreName VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_genreName
     FROM productfeatures
     WHERE id = 2;

     call p_Split_feature_names(v_genreName,"genre");

     call p_Insert_each_genre_names(v1_sub_category_id,
                                    v1_debugid);


        /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A genre name is inserted into books_f2_genres, about a nanosecond  ago');

     END;

     SQL

     execute <<-SQL
     CREATE PROCEDURE p_Insert_books_f3_isbns(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_isbn_id INT)
     BEGIN

     DECLARE v_isbn VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_isbn
     FROM productfeatures
     WHERE id = 3;

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f3_isbns
     WHERE isbn= v_isbn;

     IF v_COUNT = 0 THEN

     INSERT INTO books_f3_isbns(isbn,
                                created_at)
     values(v_isbn,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'An isbn is inserted into books_f3_isbns, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The isbn already exists so, the insert is aborted');


     END IF;

     SELECT isbn_id
     INTO v1_isbn_id
     FROM books_f3_isbns
     WHERE isbn= v_isbn;



    END;
   SQL

   execute <<-SQL

   CREATE PROCEDURE p_Insert_books_f4_isbn13s(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_isbn13_id INT)
     BEGIN

     DECLARE v_isbn13 VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_isbn13
     FROM productfeatures
     WHERE id = 4;

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f4_isbn13s
     WHERE isbn13 = v_isbn13;

     IF v_COUNT = 0 THEN

     INSERT INTO books_f4_isbn13s(isbn13,
                                  created_at)
     values(v_isbn13,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'An isbn13 is inserted into books_f4_isbn13s, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The isbn13 already exists so, the insert is aborted');


     END IF;

     SELECT isbn13_id
     INTO v1_isbn13_id
     FROM books_f4_isbn13s
     WHERE isbn13= v_isbn13;




    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f5_bindings(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_binding_id INT)
     BEGIN

     DECLARE v_binding_name VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_binding_name
     FROM productfeatures
     WHERE id = 5;

     IF lower(v_binding_name) = "n.a." THEN
     SELECT 0 INTO v1_binding_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The binding value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f5_bindings
     WHERE f_stripstring(binding_name)= f_stripstring(v_binding_name);

     IF v_COUNT = 0 THEN

     INSERT INTO books_f5_bindings(binding_name,
                                   created_at)
     values(v_binding_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A binding name is inserted into books_f5_bindings, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The binding name already exists so, the insert is aborted');


     END IF;

     SELECT binding_id
     INTO v1_binding_id
     FROM books_f5_bindings
     WHERE f_stripstring(binding_name)= f_stripstring(v_binding_name);

    END IF;

    END;

   SQL

   execute <<-SQL
   CREATE PROCEDURE p_Insert_books_f6_publishing_dates(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_publishing_date_id INT)
     BEGIN

     DECLARE v_publishing_date INT;
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_publishing_date
     FROM productfeatures
     WHERE id = 6;

     IF lower(v_publishing_date) = "n.a." THEN
     SELECT 0 INTO v1_publishing_date_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The publishing date is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f6_publishing_dates
     WHERE f_stripstring(publishing_date)= f_stripstring(v_publishing_date);

     IF v_COUNT = 0 THEN

     INSERT INTO books_f6_publishing_dates(publishing_date,
                                           created_at)
     values(v_publishing_date,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A publishing_date is inserted into books_f6_publishing_dates, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The publishing_date already exists so, the insert is aborted');


     END IF;

     SELECT publishing_date_id
     INTO v1_publishing_date_id
     FROM books_f6_publishing_dates
     WHERE f_stripstring(publishing_date)= f_stripstring(v_publishing_date);

    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f7_publishers(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_publisher_id INT)
     BEGIN

     DECLARE v_publisher VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_publisher
     FROM productfeatures
     WHERE id = 7;

     IF lower(v_publisher) = "n.a." THEN
     SELECT 0 INTO v1_publisher_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The publisher value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f7_publishers
     WHERE f_stripstring(publisher)= f_stripstring(v_publisher);

     IF v_COUNT = 0 THEN

     INSERT INTO books_f7_publishers(publisher,
                                     created_at)
     values(v_publisher,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A publisher is inserted into books_f7_publishers, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The publisher already exists so, the insert is aborted');


     END IF;

     SELECT publisher_id
     INTO v1_publisher_id
     FROM books_f7_publishers
     WHERE f_stripstring(publisher)= f_stripstring(v_publisher);


    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f8_editions(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_edition_id INT)
     BEGIN

     DECLARE v_edition_name VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_edition_name
     FROM productfeatures
     WHERE id = 8;

     IF lower(v_edition_name) = "n.a." THEN
     SELECT 0 INTO v1_edition_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The edition value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f8_editions
     WHERE f_stripstring(edition_name)= f_stripstring(v_edition_name);

     IF v_COUNT = 0 THEN

     INSERT INTO books_f8_editions(edition_name,
                                   created_at)
     values(v_edition_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A edition_name is inserted into books_f8_edition, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The edition_name already exists so, the insert is aborted');


     END IF;

     SELECT edition_id
     INTO v1_edition_id
     FROM books_f8_editions
     WHERE f_stripstring(edition_name)= f_stripstring(v_edition_name);


    END IF;

    END;
    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Insert_books_f9_languages(IN v1_sub_category_id INT, IN v1_debugid VARCHAR(255),
                                          OUT v1_language_id INT)
     BEGIN

     DECLARE v_language_name VARCHAR(255);
     DECLARE v_COUNT,v_CountFilters INT;

     SELECT val
     INTO v_language_name
     FROM productfeatures
     WHERE id = 9;

     IF lower(v_language_name) = "n.a." THEN
     SELECT 0 INTO v1_language_id;

     /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The language value is not a valid one so, the insert is aborted');

     ELSE

     SELECT COUNT(*) INTO v_COUNT
     FROM books_f9_languages
     WHERE f_stripstring(language_name)= f_stripstring(v_language_name);

     IF v_COUNT = 0 THEN

     INSERT INTO books_f9_languages(language_name,
                                    created_at)
     values(v_language_name,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'A language_name is inserted into books_f9_language, about a nanosecond ago');

     ELSE

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,'The language_name already exists so, the insert is aborted');


     END IF;

     SELECT language_id
     INTO v1_language_id
     FROM books_f9_languages
     WHERE f_stripstring(language_name)= f_stripstring(v_language_name);

    END IF;

    END;
    SQL


  end

  def down

    execute "DROP PROCEDURE p_Insert_books_f1_authors"

    execute "DROP PROCEDURE p_Insert_books_f2_genres"

    execute "DROP PROCEDURE p_Insert_books_f3_isbns"

    execute "DROP PROCEDURE p_Insert_books_f4_isbn13s"

    execute "DROP PROCEDURE p_Insert_books_f5_bindings"

    execute "DROP PROCEDURE p_Insert_books_f6_publishing_dates"

    execute "DROP PROCEDURE p_Insert_books_f7_publishers"

    execute "DROP PROCEDURE p_Insert_books_f8_editions"

    execute "DROP PROCEDURE p_Insert_books_f9_languages"

  end
end


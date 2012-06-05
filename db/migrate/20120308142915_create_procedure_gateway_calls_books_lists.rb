class CreateProcedureGatewayCallsBooksLists < ActiveRecord::Migration
def up
    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_books_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_books_lists(IN v3_product_id INT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255),
                                            IN v3_identifier1 VARCHAR(255),
                                            IN v3_identifier2 VARCHAR(255))


    BEGIN

    DECLARE v_product_features TEXT;
    DECLARE v_book_name,v_binding_name,v_publishing_date,v_publisher,v_edition_name,             v_language_name,v_availability,v_sub_category_id,v_author_name,v_genre_name,v_genre_name1,v_genre_name2 VARCHAR(255);
    DECLARE v_books_list_id,v_genre_id,v_isbn_id,v_isbn13_id,v_author_id,v_binding_id,v_publishing_date_id, v_publisher_id,v_edition_id,v_language_id,v_availability_id INT;

    DECLARE done INT DEFAULT 0;

    DECLARE cur_authors CURSOR FOR SELECT author_id FROM link_f1_books_lists WHERE books_list_id = v3_product_id;

    DECLARE cur_genres CURSOR FOR SELECT genre_id FROM link_f2_books_lists WHERE books_list_id = v3_product_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring ( v3_sub_category);

   /* ########################### Book Name ################################# */

    /* selecting the book name from the part2 db in order to
    insert into the filters collections   */

    SELECT books_list_id,book_name INTO v_books_list_id,v_book_name
    FROM books_lists
    WHERE isbn  = v3_identifier1 AND isbn13 = v3_identifier2;

    IF v_book_name IS NOT NULL AND v_books_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_book_name,
                                       v_books_list_id,
                                       "books_lists",
                                       "book_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Book name ',v_book_name,
    ' is not inserted into products_filters about a  nanosecond ago'));

     END IF;
			

   /* ############################ Book Name End ############################ */


    /* ###########################========= author ===============############*/

    OPEN cur_authors;

    WHILE NOT done DO
    FETCH cur_authors INTO v_author_id;

    IF v_author_id IS NOT NULL THEN

    SELECT author_name INTO v_author_name
    FROM books_f1_authors
    WHERE author_id  = v_author_id;



     call p_Insert_filters_collections( NULL, v_author_name,
                                       v_author_id,
                                       "LinkF1BooksLists",
                                       "author_id",
                                       v_sub_category_id,
                                       v3_debug_id);

 /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a author_name into filters ',v_author_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Author name is not inserted ',v_author_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_authors;

     SET done = 0;



    /* ###########################========= author end ===============############*/

    /* ###########################========= genre ===============############*/

    OPEN cur_genres;

    WHILE NOT done DO
    FETCH cur_genres INTO v_genre_id;

    IF v_genre_id IS NOT NULL THEN

    SELECT genre_name INTO v_genre_name
    FROM books_f2_genres
    WHERE genre_id  = v_genre_id;

    call p_Insert_filters_collections( NULL, v_genre_name,
                                       v_genre_id,
                                       "LinkF2BooksLists",
                                       "genre_id",
                                       v_sub_category_id,
                                       v3_debug_id);

      /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a genre_name into filters ',v_genre_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('genre_name is not inserted ',v_genre_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_genres;





    /* ###########################========= genre end ===============############*/
    /* ###########################========= isbn ===============############*/

     /* selecting the isbn_id from the part2 db in order to
    insert into the filters collections   */

   SELECT isbn_id INTO v_isbn_id
    FROM books_f3_isbns
    WHERE isbn  = v3_identifier1;

    call p_Insert_filters_collections( NULL, v3_identifier1,
                                       v_isbn_id,
                                       "LinkF3BooksLists",
                                       "isbn_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a isbn_id into filters ',v_isbn_id,
    ' about a  nanosecond ago'));

        /* ###########################========= isbn end===============############*/

      /* ###########################========= isbn13 ===============############*/

   /* selecting the isbn13_id from the part2 db in order to
    insert into the filters collections   */

   SELECT isbn13_id INTO v_isbn13_id
    FROM books_f4_isbn13s
    WHERE isbn13  = v3_identifier2;

    call p_Insert_filters_collections( NULL, v3_identifier2,
                                       v_isbn13_id,
                                       "LinkF4BooksLists",
                                       "isbn13_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a isbn13_id into filters ',v_isbn13_id,
    ' about a  nanosecond ago'));

    /* ###########################========= isbn13 end ===============############*/

    /* ###########################========= binding ===============############*/


      /* selecting the binding from the part2 db in order to
    insert into the filters collections   */

    SELECT binding_id  INTO v_binding_id
    FROM link_f5_books_lists
    WHERE books_list_id = v3_product_id;

    IF v_binding_id IS NOT NULL THEN

    SELECT binding_name INTO v_binding_name
    FROM books_f5_bindings
    WHERE binding_id  = v_binding_id;

    call p_Insert_filters_collections( NULL, v_binding_name,
                                       v_binding_id,
                                       "LinkF5BooksLists",
                                       "binding_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a binding_name into filters ',v_binding_name,
    ' about a  nanosecond ago'));

    ELSE

     /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the binding name ',v_binding_name,
    ' about a  nanosecond ago'));


    END IF;

    /* ###########################========= binding end ===============############*/


    /* ###########################========= publishing date ===============############*/

    /* selecting the publishing date from the part2 db in order to
    insert into the filters collections   */

    SELECT publishing_date_id  INTO v_publishing_date_id
    FROM link_f6_books_lists
    WHERE books_list_id = v3_product_id;

    IF v_publishing_date_id IS NOT NULL THEN

    SELECT publishing_date INTO v_publishing_date
    FROM books_f6_publishing_dates
    WHERE publishing_date_id  = v_publishing_date_id;

    call p_Insert_filters_collections( NULL, v_publishing_date,
                                       v_publishing_date_id,
                                       "LinkF6BooksLists",
                                       "publishing_date_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a publishing_date into filters ',v_publishing_date,
    ' about a  nanosecond ago'));


    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the publishing date  ',v_publishing_date,
    ' about a  nanosecond ago'));

    END IF;
    /* ###########################========= publishing date end ===============############*/


    /* ###########################========= publisher ===============############*/

    /* selecting the publisher from the part2 db in order to
    insert into the filters collections   */

    SELECT publisher_id  INTO v_publisher_id
    FROM link_f7_books_lists
    WHERE books_list_id = v3_product_id;

    IF v_publisher_id IS NOT NULL THEN

    SELECT publisher INTO v_publisher
    FROM books_f7_publishers
    WHERE publisher_id  = v_publisher_id;

    call p_Insert_filters_collections( NULL, v_publisher,
                                       v_publisher_id,
                                       "LinkF7BooksLists",
                                       "publisher_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a publisher into filters ',v_publisher,
    ' about a  nanosecond ago'));

    ELSE

       /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the publisher ',v_publisher,
    ' about a  nanosecond ago'));

    END IF;

    /* ###########################========= publisher end  ===============############*/

    /* ###########################========= edition ===============############*/

    /* selecting the edition from the part2 db in order to
    insert into the filters collections   */

    SELECT edition_id  INTO v_edition_id
    FROM link_f8_books_lists
    WHERE books_list_id = v3_product_id;

    IF v_edition_id IS NOT NULL THEN

    SELECT edition_name INTO v_edition_name
    FROM books_f8_editions
    WHERE edition_id  = v_edition_id;

    call p_Insert_filters_collections( NULL, v_edition_name,
                                       v_edition_id,
                                       "LinkF8BooksLists",
                                       "edition_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a edition_name into filters ',v_edition_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the edition name ',v_edition_name,
    ' about a  nanosecond ago'));
    END IF;

    /* ###########################========= edition end  ===============############*/

    /* ###########################========= language ===============############*/

    /* selecting the language from the part2 db in order to
    insert into the filters collections   */

    SELECT language_id  INTO v_language_id
    FROM link_f9_books_lists
    WHERE books_list_id = v3_product_id;

    IF v_language_id IS NOT NULL THEN


    SELECT language_name INTO v_language_name
    FROM books_f9_languages
    WHERE language_id  = v_language_id;

    call p_Insert_filters_collections( NULL, v_language_name,
                                       v_language_id,
                                       "LinkF9BooksLists",
                                       "language_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a language_name into filters ',v_language_name,
    ' about a  nanosecond ago'));

    ELSE

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted language ',v_language_name,
    ' about a  nanosecond ago'));


    END IF;

    /* ###########################========= language end  ===============############*/


    /* ###########################========= availability ===============############*/

   /* availability is no more a books specific feature, it is a features
   specific to vendors and books and in such cases, we at crawlfish
   push 'em into PART3 DB */

    /* ###########################========= availability end  ===============############*/

  END;

  SQL

  end

  def down

    execute "DROP PROCEDURE p_gateway_calls_books_lists"

  end
end


class CreateTriggerInsertOnBooksLists < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Books_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Books_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Books_Lists"

    execute <<-SQL
    CREATE TRIGGER t_Insert_Books_Lists AFTER INSERT ON books_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_Insert_Books_Lists';


    DECLARE  v_sub_category_id,v_book_name_id,v_author_id,v_genre_id,v_isbn_id,v_isbn13_id,v_binding_id,v_publishing_date_id,
    v_publisher_id,v_edition_id,v_language_id,v_availability_id INT;

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);


    /* ########### Dropping the temporary tables before trigger starts ################# */
     DROP TEMPORARY TABLE IF EXISTS productfeatures;


     IF f_createproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not created successfully');

    END IF;



     IF f_productfeatures(new.book_features, 9) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The book features are extracted from books_lists, parsed
    and saved into productfeatures table, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The book features are not successfully saved into productfeatures table');

    END IF;

    /* call the following procedure to insert/ignore a book feature from books_lists table into index tables based */
    /* on its non-existence/existence respectively */


    call p_Insert_books_f1_authors(v_sub_category_id,v_DebugID);

    call p_Insert_link_f1_books_lists(new.books_list_id,v_DebugID);

    call p_Insert_books_f2_genres(v_sub_category_id,v_DebugID);

    call p_Insert_link_f2_books_lists(new.books_list_id,v_DebugID);

    call p_Insert_books_f3_isbns(v_sub_category_id,v_DebugID,v_isbn_id);

    call p_Insert_link_f3_books_lists(new.books_list_id, v_isbn_id, v_DebugID);

    call p_Insert_books_f4_isbn13s(v_sub_category_id,v_DebugID,v_isbn13_id);

    call p_Insert_link_f4_books_lists(new.books_list_id, v_isbn13_id, v_DebugID);

    call p_Insert_books_f5_bindings(v_sub_category_id,v_DebugID,v_binding_id);

    call p_Insert_link_f5_books_lists(new.books_list_id, v_binding_id, v_DebugID);

    call p_Insert_books_f6_publishing_dates(v_sub_category_id,v_DebugID,v_publishing_date_id);

    call p_Insert_link_f6_books_lists(new.books_list_id, v_publishing_date_id, v_DebugID);

    call p_Insert_books_f7_publishers(v_sub_category_id,v_DebugID,v_publisher_id);

    call p_Insert_link_f7_books_lists(new.books_list_id, v_publisher_id, v_DebugID);

    call p_Insert_books_f8_editions (v_sub_category_id,v_DebugID,v_edition_id);

    call p_Insert_link_f8_books_lists(new.books_list_id, v_edition_id, v_DebugID);

    call p_Insert_books_f9_languages(v_sub_category_id,v_DebugID,v_language_id);

    call p_Insert_link_f9_books_lists(new.books_list_id, v_language_id, v_DebugID);




     IF f_flushproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is dropped successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not dropped successfully');

    END IF;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure to check priority error table');

    call p_Check_priority_table("books_lists",new.book_name,new.isbn,new.isbn13);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL


    execute <<-SQL
    CREATE TRIGGER t_Update_Books_Lists AFTER UPDATE ON books_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_Update_Books_Lists';


    DECLARE  v_sub_category_id,v_book_name_id,v_author_id,v_genre_id,v_isbn_id,v_isbn13_id,v_binding_id,v_publishing_date_id,
    v_publisher_id,v_edition_id,v_language_id,v_availability_id INT;


    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);


    /* ########### Dropping the temporary tables before trigger starts ################# */
     DROP TEMPORARY TABLE IF EXISTS productfeatures;


     IF f_createproductfeatures() THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The table productfeatures is created successfully, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The productfeatures table is not created successfully');

    END IF;



     IF f_productfeatures(new.book_features, 9) THEN

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The book features are extracted from books_lists, parsed
    and saved into productfeatures table, about a nanosecond ago');

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'The book features are not successfully saved into productfeatures table');

    END IF;

    /* call the following procedure to insert/ignore a book feature from books_lists table into index tables based */
    /* on its non-existence/existence respectively */



    call p_Insert_books_f1_authors(v_sub_category_id,v_DebugID);

    call p_Insert_link_f1_books_lists(new.books_list_id,v_DebugID);


    call p_Insert_books_f2_genres(v_sub_category_id,v_DebugID);

    call p_Insert_link_f2_books_lists(new.books_list_id,v_DebugID);


    call p_Insert_books_f3_isbns(v_sub_category_id,v_DebugID,v_isbn_id);

    call p_Insert_link_f3_books_lists(new.books_list_id, v_isbn_id, v_DebugID);


    call p_Insert_books_f4_isbn13s(v_sub_category_id,v_DebugID,v_isbn13_id);

    call p_Insert_link_f4_books_lists(new.books_list_id, v_isbn13_id, v_DebugID);


    call p_Insert_books_f5_bindings(v_sub_category_id,v_DebugID,v_binding_id);

    call p_Insert_link_f5_books_lists(new.books_list_id, v_binding_id, v_DebugID);


    call p_Insert_books_f6_publishing_dates(v_sub_category_id,v_DebugID,v_publishing_date_id);

    call p_Insert_link_f6_books_lists(new.books_list_id, v_publishing_date_id, v_DebugID);


    call p_Insert_books_f7_publishers(v_sub_category_id,v_DebugID,v_publisher_id);

    call p_Insert_link_f7_books_lists(new.books_list_id, v_publisher_id, v_DebugID);


    call p_Insert_books_f8_editions (v_sub_category_id,v_DebugID,v_edition_id);

    call p_Insert_link_f8_books_lists(new.books_list_id, v_edition_id, v_DebugID);


    call p_Insert_books_f9_languages(v_sub_category_id,v_DebugID,v_language_id);

    call p_Insert_link_f9_books_lists(new.books_list_id, v_language_id, v_DebugID);




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

    CREATE TRIGGER t_Delete_Books_Lists BEFORE DELETE ON books_lists
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_D_B_',old.books_list_id,'_',old.book_name);



    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	   
    call p_Delete_link_f1_books_lists(old.books_list_id,v_DebugID);


    call p_Delete_link_f2_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f3_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f4_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f5_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f6_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f7_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f8_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_link_f9_books_lists(old.books_list_id, v_DebugID);


    call p_Delete_books_reviews(old.books_list_id, v_DebugID);



    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL


  end

  def down

    execute "DROP TRIGGER IF EXISTS t_Insert_Books_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Books_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Books_Lists"

  end
end


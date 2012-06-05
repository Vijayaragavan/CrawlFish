class CreateTriggerOnBooksReviews < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_books_reviews"
    execute "DROP TRIGGER IF EXISTS t_Delete_books_reviews"

    execute <<-SQL
    CREATE TRIGGER t_Insert_books_reviews AFTER INSERT ON books_reviews
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Insert_books_reviews';
    DECLARE v_books_list_id, v_id, v_count, v_fixed_flag INT;
    DECLARE v_book_name, v_isbn, v_isbn13 VARCHAR(255);
    DECLARE v_message VARCHAR(255) DEFAULT 'The product from reviews is not present in part-2';

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

	SELECT COUNT(*) INTO v_count FROM books_lists
	WHERE LOWER(isbn13) = LOWER(new.isbn13);

	IF v_count = 1 THEN

	SELECT books_list_id, book_name, isbn, isbn13 INTO v_books_list_id, v_book_name, v_isbn, v_isbn13 FROM books_lists
	WHERE LOWER(isbn13) = LOWER(new.isbn13);

	INSERT INTO link_books_lists_reviews(books_list_id, books_reviews_id, created_at)
	VALUES(v_books_list_id, new.id, CURRENT_TIMESTAMP);
	
	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v_DebugID,CONCAT('Inserted a new record into books_reviews table for the isbn13 ',new.isbn13));

	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v_DebugID,'Calling the procedure to check priority error table');

	call p_Check_priority_table("books_lists",v_book_name,v_isbn,v_isbn13);

	ELSEIF v_count = 0 THEN

	call p_Insert_priority_errors("books_lists","NA",new.isbn,new.isbn13,v_message,v_fixed_flag,v_DebugID);

        /* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v_DebugID,'Stopped insert and given a priority error message - id not found in part2 db- to priority_errors table, about a  	nanosecond ago');
	
	END IF;

    /*Turning off the debug insert*/
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_Delete_books_reviews BEFORE DELETE ON books_reviews
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID VARCHAR(255) DEFAULT 't_Delete_books_reviews';


    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);

	DELETE FROM link_books_lists_reviews WHERE books_reviews_id = old.id;
	
	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v_DebugID,CONCAT('Deleted the record from link_books_lists_reviews table for the id ',old.id));

    /*Turning off the debug insert*/
    call debug.debug_off(v_DebugID);

    END
    SQL


  end

  def down
    execute "DROP TRIGGER t_Insert_books_reviews"
  end
end

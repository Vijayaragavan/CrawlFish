class CreateProcedureDeleteLinkBooksLists < ActiveRecord::Migration
  def up


    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f1_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f1_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f1_books_lists, about a nanosecond ago'));


    END;

    SQL


    execute <<-SQL

    CREATE PROCEDURE p_Delete_link_f2_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f2_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f2_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f3_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f3_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f3_books_lists, about a nanosecond ago'));

    

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f4_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f4_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f4_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f5_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f5_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f5_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f6_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f6_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f6_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f7_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f7_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f7_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f8_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f8_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f8_books_lists, about a nanosecond ago'));



    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f9_books_lists(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f9_books_lists WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the books_list_id ',v1_books_list_id,
      ' has been deleted from link_f9_books_lists, about a nanosecond ago'));

     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_books_reviews(IN v1_books_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM books_reviews WHERE books_list_id = v1_books_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('All the reviews present for the books_list_id ',v1_books_list_id,
      ' has been deleted from books_reviews table, about a nanosecond ago'));

     

    END;

    SQL


  end

  def down

    execute "DROP PROCEDURE p_Delete_link_f1_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f2_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f3_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f4_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f5_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f6_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f7_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f8_books_lists"

    execute "DROP PROCEDURE p_Delete_link_f9_books_lists"

    execute "DROP PROCEDURE p_Delete_books_reviews"


  end
end


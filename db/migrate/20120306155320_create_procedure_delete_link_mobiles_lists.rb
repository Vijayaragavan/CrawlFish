class CreateProcedureDeleteLinkMobilesLists < ActiveRecord::Migration
  def up


    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f1_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f1_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f1_mobiles_lists, about a nanosecond ago'));


    END;

    SQL


    execute <<-SQL

    CREATE PROCEDURE p_Delete_link_f2_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f2_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f2_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f3_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f3_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f3_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f4_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f4_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f4_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f5_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f5_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f5_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f5_c_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f5_c_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f5_c_mobiles_lists, about a nanosecond ago'));
     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f6_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f6_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f6_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f7_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f7_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f7_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f8_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f8_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f8_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f9_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f9_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f9_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f10_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f10_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f10_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f11_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f11_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f11_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f12_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f12_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f12_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f13_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f13_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f13_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL


    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f14_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f14_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f14_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f15_mobiles_lists(IN v1_mobiles_list_id INT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN


	DELETE FROM link_f15_mobiles_lists WHERE mobiles_list_id = v1_mobiles_list_id;


      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('A link for the mobiles_list_id ',v1_mobiles_list_id,
      ' has been deleted from link_f15_mobiles_lists, about a nanosecond ago'));


     

    END;

    SQL



  end

  def down

    execute "DROP PROCEDURE p_Delete_link_f1_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f2_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f3_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f4_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f5_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f5_c_mobiles_lists" 

    execute "DROP PROCEDURE p_Delete_link_f6_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f7_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f8_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f9_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f10_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f11_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f12_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f13_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f14_mobiles_lists"

    execute "DROP PROCEDURE p_Delete_link_f15_mobiles_lists"

  end
end


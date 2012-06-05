class CreateDebugTablesAndProcedures < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS debug.debug"
    execute <<-SQL
    CREATE TABLE  debug.debug (
      created_at DATE,
      id VARCHAR(255) NOT NULL,
      debug_output TEXT,
      line_id INT NOT NULL AUTO_INCREMENT,
      PRIMARY KEY  (line_id)
    );
    SQL

    execute "DROP PROCEDURE IF EXISTS debug.debug_on"

    execute <<-SQL
    CREATE PROCEDURE debug.debug_on(in p_proc_id VARCHAR(255))
      begin
        insert into debug (created_at,id,debug_output)
        values (curdate(),'#########','#########');
        call debug.debug_insert(p_proc_id,concat('Debug Started :',now()));
      end;
    SQL

    execute "DROP PROCEDURE IF EXISTS debug.debug_insert"

    execute <<-SQL
    CREATE PROCEDURE debug.debug_insert(in p_proc_id VARCHAR(255),in p_debug_info TEXT)
    begin
      insert into debug (created_at,id,debug_output)
      values (curdate(),p_proc_id,p_debug_info);

    end
    SQL

    execute "DROP PROCEDURE IF EXISTS debug.debug_off"

    execute <<-SQL
    CREATE PROCEDURE debug.debug_off(in p_proc_id VARCHAR(255))
      begin
        call debug.debug_insert(p_proc_id,concat('Debug Ended :',now()));
        insert into debug (created_at,id,debug_output)
        values (curdate(),'#########','#########');

      end
    SQL

  end

  def down

    execute "DROP PROCEDURE IF EXISTS debug.debug_off"
    execute "DROP PROCEDURE IF EXISTS debug.debug_insert"
    execute "DROP PROCEDURE IF EXISTS debug.debug_on"
    execute "DROP TABLE IF EXISTS debug.debug"

  end
end


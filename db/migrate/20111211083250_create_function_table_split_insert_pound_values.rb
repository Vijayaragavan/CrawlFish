class CreateFunctionTableSplitInsertPoundValues < ActiveRecord::Migration
  def up

    execute "DROP FUNCTION IF EXISTS f_parsefeatures"

    execute <<-SQL

    CREATE FUNCTION f_createparsedfeatures()
    RETURNS BOOLEAN
    BEGIN
    CREATE TEMPORARY TABLE parsedfeatures(id INT NOT NULL AUTO_INCREMENT, val VARCHAR(255),PRIMARY KEY (id));
    RETURN true;
    END;

    SQL

    execute <<-SQL

    CREATE FUNCTION f_parsefeatures(carrier TEXT)
    RETURNS BOOLEAN
    BEGIN
    DECLARE loopcounter INT Default 1 ;
    DECLARE quantity INT Default 10 ;

    DECLARE v_value VARCHAR(255);
    DECLARE delimiter CHAR(1) Default "#";

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_value = SUBSTRING_INDEX(SUBSTRING_INDEX(carrier,delimiter,loopcounter),delimiter,-1);
              INSERT INTO parsedfeatures(val) values(v_value);
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    RETURN true;

    END;

    SQL

    execute <<-SQL

    CREATE FUNCTION f_flushparsedfeatures()
    RETURNS BOOLEAN
    BEGIN
      DROP TEMPORARY TABLE IF EXISTS parsedfeatures;
      RETURN true;
    END;
    SQL

  end

  def down

    execute "DROP FUNCTION f_parsefeatures"

    execute "DROP FUNCTION f_flushparsedfeatures"

    execute "DROP FUNCTION f_createparsedfeatures"

    execute "DROP TEMPORARY TABLE IF EXISTS parsedfeatures"

  end
end


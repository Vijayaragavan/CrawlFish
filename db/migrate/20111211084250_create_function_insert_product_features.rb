class CreateFunctionInsertProductFeatures < ActiveRecord::Migration
    def up

    execute "DROP FUNCTION IF EXISTS f_productfeatures"
    execute "DROP FUNCTION IF EXISTS f_splitattributes"
    execute "DROP FUNCTION IF EXISTS f_createproductfeatures"
    execute "DROP FUNCTION IF EXISTS f_createattributes"
    execute "DROP FUNCTION IF EXISTS f_flushproductfeatures"
    execute "DROP FUNCTION IF EXISTS f_flushattributes"

    execute <<-SQL

    CREATE FUNCTION f_createproductfeatures()
    RETURNS BOOLEAN
    BEGIN
    CREATE TEMPORARY TABLE productfeatures(id INT NOT NULL AUTO_INCREMENT, val TEXT, PRIMARY KEY (id));
    RETURN true;
    END;

    SQL

    execute <<-SQL

    CREATE FUNCTION f_createattributes()
    RETURNS BOOLEAN
    BEGIN
    CREATE TEMPORARY TABLE attributes(id INT NOT NULL AUTO_INCREMENT, val TEXT, PRIMARY KEY (id));
    RETURN true;
    END;

    SQL


    execute <<-SQL

    CREATE FUNCTION f_productfeatures(carrier TEXT, count INT)
    RETURNS BOOLEAN
    BEGIN
    DECLARE loopcounter INT Default 1 ;
    DECLARE quantity INT;

    DECLARE v_value TEXT;
    DECLARE delimiter CHAR(1) Default "#";

    SET quantity = count;

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_value = SUBSTRING_INDEX(SUBSTRING_INDEX(carrier,delimiter,loopcounter),delimiter,-1);
              INSERT INTO productfeatures(val) values(v_value);
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    RETURN true;

    END;

    SQL

    execute <<-SQL

    CREATE FUNCTION f_splitattributes(carrier TEXT, count INT)
    RETURNS BOOLEAN
    BEGIN
    DECLARE loopcounter INT Default 1 ;
    DECLARE quantity INT;

    DECLARE v_value TEXT;
    DECLARE delimiter CHAR(1) Default "$";

    SET quantity = count;

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_value = SUBSTRING_INDEX(SUBSTRING_INDEX(carrier,delimiter,loopcounter),delimiter,-1);
              INSERT INTO attributes(val) values(v_value);
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    RETURN true;

    END;

    SQL


    execute <<-SQL

    CREATE FUNCTION f_flushproductfeatures()
    RETURNS BOOLEAN
    BEGIN
      DROP TEMPORARY TABLE productfeatures;
      RETURN true;
    END;
    SQL

    execute <<-SQL

    CREATE FUNCTION f_flushattributes()
    RETURNS BOOLEAN
    BEGIN
      DROP TEMPORARY TABLE attributes;
      RETURN true;
    END;
    SQL


  end

  def down

    execute "DROP FUNCTION f_productfeatures"
    execute "DROP FUNCTION f_splitattributes"
    execute "DROP FUNCTION f_createproductfeatures"
    execute "DROP FUNCTION f_createattributes"
    execute "DROP FUNCTION f_flushproductfeatures"
    execute "DROP FUNCTION f_flushattributes"

  end
end


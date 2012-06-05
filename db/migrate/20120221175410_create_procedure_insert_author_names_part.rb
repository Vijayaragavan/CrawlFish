class CreateProcedureInsertAuthorNamesPart < ActiveRecord::Migration
  def up

   execute <<-SQL
    CREATE PROCEDURE p_Insert_each_author_names(IN v1_sub_category_id INT,
                                                         IN v1_debugid VARCHAR(255))
    BEGIN

    DECLARE v_count INT Default 0;
    DECLARE loopcounter INT Default 1;
    DECLARE v_currentName VARCHAR(255);
    DECLARE v_author_id INT;
    DECLARE v_countAuthorNames INT Default 0;
    DECLARE v_trimCurrentName VARCHAR(255);


    SELECT COUNT(*) INTO v_count
    FROM features;

    carrier_loop: LOOP
      IF loopcounter <= v_count THEN

         SELECT name INTO v_currentName
         FROM features
         WHERE id = loopcounter;

      IF LOWER(v_currentName) = "n.a." THEN

      SELECT 0 INTO v_author_id;

      ELSE

         SET v_trimCurrentName = LTRIM(RTRIM(v_currentName));

         SELECT COUNT(*) INTO v_countAuthorNames
         FROM books_f1_authors
         WHERE f_stripstring(author_name) = f_stripstring(v_trimCurrentName);

         IF v_countAuthorNames = 0 THEN


         INSERT INTO books_f1_authors (author_name,
                                       created_at)
         VALUES (v_trimCurrentName,
                 CURRENT_TIMESTAMP);



         SELECT author_id
         INTO v_author_id
         FROM books_f1_authors
         WHERE f_stripstring(author_name)= f_stripstring(v_trimCurrentName);

         UPDATE features
         SET features_id = v_author_id
         WHERE f_stripstring(name)= f_stripstring(v_trimCurrentName);


     ELSE

      SELECT author_id INTO v_author_id
      FROM books_f1_authors
      WHERE f_stripstring(author_name) = f_stripstring(v_trimCurrentName);


      UPDATE features
      SET features_id = v_author_id
      WHERE f_stripstring(name)= f_stripstring(v_trimCurrentName);


     END IF;

      UPDATE features
      SET features_id = v_author_id
      WHERE f_stripstring(name)= f_stripstring(v_trimCurrentName);

     END IF;

      ELSE
              LEAVE carrier_loop;
      END IF;


      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;



     END;

    SQL


  end

  def down

     execute "DROP PROCEDURE p_Insert_each_author_names"

  end
end


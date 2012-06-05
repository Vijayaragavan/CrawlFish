class CreateProcedureInsertIntoFiltersCollections < ActiveRecord::Migration
def up

 execute "DROP PROCEDURE IF EXISTS p_Insert_filters_collections"
 execute <<-SQL

  CREATE PROCEDURE p_Insert_filters_collections( IN v_filter_identifier VARCHAR(255), 
       IN v1_filter_key VARCHAR(255),
       IN v1_filter_id INT,
       IN v1_filter_table_name VARCHAR(255),
       IN v1_filter_table_column VARCHAR(255),
       IN v1_sub_category_id INT,
       IN v1_debugid VARCHAR(255))
BEGIN

 DECLARE v_firstLetter CHAR(1);
 DECLARE v_count INT DEFAULT 0;

IF lower(v1_filter_key) = "n.a." THEN
      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v1_debugid,concat('Filter_key - ',v1_filter_key,' is not a valid filter key and hence it is not inserted into filters_collections'));

ELSE	

	IF v_filter_identifier = "products_name" THEN
	  SELECT COUNT(*) INTO v_count FROM products_filter_collections
	  WHERE f_stripstring(filter_key) = f_stripstring(v1_filter_key) AND filter_id = v1_filter_id AND filter_table_column = v1_filter_table_column AND filter_table_name = v1_filter_table_name;

		  IF v_count = 0 THEN
		  INSERT INTO products_filter_collections(filter_key,filter_id,filter_table_name,filter_table_column,sub_category_id,created_at)
		  VALUES(v1_filter_key,v1_filter_id,v1_filter_table_name,v1_filter_table_column, v1_sub_category_id,CURRENT_TIMESTAMP);

		      /* Insert a record in debug table for tracking the events */
		      call debug.debug_insert(v1_debugid,concat('A filter_key - ',v1_filter_key,' is inserted into filters_collections'));

		  ELSE

	          /* Insert a record in debug table for tracking the events */
	          call debug.debug_insert(v1_debugid,concat('Filter_key - ',v1_filter_key,' already exists in products_filter_collections'));
		
		 END IF;

	ELSE

	  SELECT COUNT(*) INTO v_count FROM filters_collections
	  WHERE f_stripstring(filter_key) = f_stripstring(v1_filter_key) AND filter_id = v1_filter_id AND filter_table_column = v1_filter_table_column AND filter_table_name = v1_filter_table_name;
	
	    IF v_count = 0 THEN
	      INSERT INTO filters_collections(filter_key,filter_id,filter_table_name,filter_table_column,sub_category_id,created_at)
	      VALUES(v1_filter_key,v1_filter_id,v1_filter_table_name,v1_filter_table_column, v1_sub_category_id,CURRENT_TIMESTAMP);
	
	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,concat('A filter_key - ',v1_filter_key,' is inserted into filters_collections'));
	    ELSE
	
	      /* Insert a record in debug table for tracking the events */
	      call debug.debug_insert(v1_debugid,concat('Filter_key - ',v1_filter_key,' is NOT inserted into filters_collections'));
	    END IF;
	
	END IF;
	
END IF;

END;
  SQL
  end

  def down
  execute "DROP PROCEDURE p_Insert_filters_collections"
  end
end


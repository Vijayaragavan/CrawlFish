class CreateProcedureCheckPriorityTable < ActiveRecord::Migration
  def up

	execute "DROP PROCEDURE IF EXISTS p_Check_priority_table"

	execute <<-SQL

	CREATE PROCEDURE p_Check_priority_table(IN v1_sub_category VARCHAR(255),
						IN v1_prod_name VARCHAR(255),
						IN v1_identifier1 VARCHAR(255),
						IN v1_identifier2 VARCHAR(255))

	BEGIN

		IF v1_sub_category = "books_lists" THEN

		UPDATE priority_errors SET fixed = 1 WHERE product_sub_category = v1_sub_category AND 
		identifier1 = v1_identifier1 AND v1_identifier2 = v1_identifier2;

		ELSE

		UPDATE priority_errors SET fixed = 1 WHERE product_sub_category = v1_sub_category AND 
		identifier1 = v1_identifier1 AND v1_identifier2 = v1_identifier2 AND product_name = v1_prod_name;

		END IF;

	END

	SQL
	
  end

  def down
	execute "DROP PROCEDURE p_Check_priority_table"
  end
end

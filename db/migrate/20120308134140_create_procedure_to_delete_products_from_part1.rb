class CreateProcedureToDeleteProductsFromPart1 < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_Delete_products_from_Part1"

    execute <<-SQL
    CREATE PROCEDURE p_Delete_products_from_Part1()
    BEGIN

    DECLARE v_table_name, v_product_name, v_identifier1, v_identifier2, v_query, v_prep, v_isbn13 VARCHAR(500);
    DECLARE v_count, v_p_er_id INT;
    DECLARE loopcounter INT DEFAULT 1;

    SELECT count(*) INTO v_count FROM vendor_data_priorities;

    carrier_loop: LOOP
     IF loopcounter <= v_count THEN
        /* added stripstring functions to varchar by senthil 2012may16 */
	SELECT vendor_table_name,f_stripstring(product_name),f_stripstring(product_identifier1),f_stripstring(product_identifier2) INTO
	v_table_name,v_product_name,v_identifier1,v_identifier2 FROM vendor_data_priorities
	WHERE id=loopcounter;

	IF v_table_name IS NOT NULL THEN
       /* added stripstring functions to varchar by senthil 2012may16 */ 
	SET @v_query = CONCAT('DELETE FROM ',v_table_name,' WHERE f_stripstring(product_name) = ? AND f_stripstring(product_identifier1) = ? AND f_stripstring(product_identifier2) = ?');

	PREPARE v_prep FROM @v_query;

	SET @b=v_product_name;
	SET @c=v_identifier1;
	SET @d=v_identifier2;

	EXECUTE v_prep USING @b,@c,@d;

	DEALLOCATE PREPARE v_prep;

	END IF;

     ELSE
	LEAVE carrier_loop;
     END IF;
	SET loopcounter = loopcounter + 1;
     END LOOP carrier_loop;


    SELECT MAX(id) INTO v_p_er_id FROM priority_errors;
    SET loopcounter = 1;

    carrier_loop: LOOP
     IF loopcounter <= v_p_er_id THEN
        /* added stripstring functions to varchar by senthil 2012may16 */
	SELECT identifier2 INTO v_isbn13 FROM priority_errors
	WHERE id=loopcounter AND product_sub_category = "books_lists";
    
	DELETE FROM books_reviews WHERE isbn13 = v_isbn13; 
     ELSE
	LEAVE carrier_loop;
     END IF;
	SET loopcounter = loopcounter + 1;
     END LOOP carrier_loop;

    END;

    SQL

  end

  def down

   execute "DROP PROCEDURE p_Delete_products_from_Part1"

  end
end

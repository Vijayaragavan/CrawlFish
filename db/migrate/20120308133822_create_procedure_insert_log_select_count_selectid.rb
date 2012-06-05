class CreateProcedureInsertLogSelectCountSelectid < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Insertlog_selectcount_selectid"

    execute <<-SQL


   CREATE PROCEDURE p_Insertlog_selectcount_selectid(IN v1_configured_by VARCHAR(255),
                                                      IN v1_reason VARCHAR(255),
                                                      IN v1_validity VARCHAR(255),
						      IN v1_product_sub_category VARCHAR(255),
						      IN v1_product_name VARCHAR(255),
                                                      IN v1_product_id INT,
                                                      IN v1_vendorID INT,
                                                      OUT v1_countproductslists INT,
                                                      OUT v1_products_list_id INT,
                                                      IN v1_product_identifier1 VARCHAR(255),
                                                      IN v1_product_identifier2 VARCHAR(255),
                                                      IN v1_debugid VARCHAR(255))
     BEGIN


    /* Finding the sub_category id */

    DECLARE v_sub_category_id INT;

    SELECT sub_category_id INTO v_sub_category_id FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring(v1_product_sub_category);

    /* Insert a log into vendors_config_logs table for every insert in online_flipkart_products table */
    INSERT
    INTO vendors_config_logs(configured_by,
                                    reason,
                                    validity,
                                    product_id,
                                    vendor_id,
				    sub_category_id,
                                    created_at)
    VALUES( v1_configured_by,
            v1_reason,
            v1_validity,
            v1_product_id,
            v1_vendorID,
	    v_sub_category_id,
            now());

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'A record is inserted into the vendors_config_logs about a nanosecond ago');

    
    IF LOWER(v1_product_sub_category) = "books_lists" THEN

	/* ####### Books Lists #######	*/

     /* select the count of books in books_lists using isbn, isbn13 and book_name from books_lists */
    /* and product_name and   product_features in online_flipkart_products table  */
    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM books_lists
    WHERE f_stripstring(isbn) = f_stripstring(v1_product_identifier1)
    AND f_stripstring(isbn13) = f_stripstring(v1_product_identifier2);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Books_lists for ',v1_product_identifier1,
    ' and found ',v1_countproductslists,' book(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT books_list_id
    INTO v1_products_list_id
    FROM books_lists
    WHERE f_stripstring(isbn) = f_stripstring(v1_product_identifier1)
    AND f_stripstring(isbn13) = f_stripstring(v1_product_identifier2);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the idetifiers ',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "mobiles_lists" THEN

	/* ####### Mobiles Lists #######	*/

     /* select the count of mobiles in mobiles_lists using mobile name, mobile brand and mobile color from mobiles_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM mobiles_lists
    WHERE f_stripstring(mobile_brand) = f_stripstring(v1_product_identifier1)
    AND f_stripstring(mobile_color) = f_stripstring(v1_product_identifier2)
    AND f_stripstring(mobile_name) = f_stripstring(v1_product_name);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Mobiles_lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' mobile(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT mobiles_list_id
    INTO v1_products_list_id
    FROM mobiles_lists
    WHERE f_stripstring(mobile_brand) = f_stripstring(v1_product_identifier1)
    AND f_stripstring(mobile_color) = f_stripstring(v1_product_identifier2)
    AND f_stripstring(mobile_name) = f_stripstring(v1_product_name);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the idetifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


     END;

     SQL

  end

  def down

    execute "DROP PROCEDURE p_Insertlog_selectcount_selectid"

  end
end


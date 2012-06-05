class CreateProcedureInsertIntoLinkProductsListsVendors < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_Insert_delete_uniqueid"

    execute <<-SQL
    CREATE PROCEDURE p_Insert_delete_uniqueid(  IN v1_debug_id VARCHAR(255),
						IN v1_delete_flag INT,
						IN v1_product_sub_category VARCHAR(255),
                                                IN v1_products_list_id INT,
                                                IN v1_vendor_id INT,
                                                IN v1_availability_id INT,
                                                OUT v1_unique_id BIGINT)
     BEGIN

     /* Declare a count variable to count the number of rows in link_products_lists_vendors for the given products_list_id and vendor_id */
     DECLARE v_COUNTLinksproductsVendorsID INT DEFAULT 0;
     DECLARE v1_product_sub_category_id INT;

   
    /* Finding the sub category id */
    SELECT sub_category_id INTO v1_product_sub_category_id FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring(v1_product_sub_category);


    /* Select the count of links for this vendor_id and products_list_id from link_products_lists_vendors */
    SELECT COUNT(*) INTO v_COUNTLinksproductsVendorsID
    FROM link_products_lists_vendors
    WHERE vendor_id = v1_vendor_id AND products_list_id = v1_products_list_id AND sub_category_id = v1_product_sub_category_id;


    IF v_COUNTLinksproductsVendorsID <>0  AND v1_delete_flag = 1 THEN

        /* Select the count of links for this vendor_id and products_list_id from link_products_lists_vendors */
       SELECT unique_id INTO v1_unique_id
       FROM link_products_lists_vendors
       WHERE vendor_id = v1_vendor_id AND products_list_id = v1_products_list_id AND sub_category_id = v1_product_sub_category_id;


       DELETE FROM link_products_lists_vendors
       WHERE unique_id = v1_unique_id;

	    /* Delete a record from debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,'A record is deleted from link_products_lists_vendors, about a  nanosecond ago');


    ELSEIF v_COUNTLinksproductsVendorsID = 0 AND v1_delete_flag = 0 THEN

       /* Inserting the values of vendor_id and products_list_id in to link_products_lists_vendors to create the link and this */
       /* will generate a unique_id */

	SET FOREIGN_KEY_CHECKS = 0;
	
       INSERT INTO link_products_lists_vendors(vendor_id,products_list_id,sub_category_id,availability_id,created_at)
       VALUES(v1_vendor_id,v1_products_list_id,v1_product_sub_category_id,v1_availability_id,now());

	SET FOREIGN_KEY_CHECKS = 1;

       /* Select the count of links for this vendor_id and products_list_id from link_products_lists_vendors */
       SELECT unique_id INTO v1_unique_id
       FROM link_products_lists_vendors
       WHERE vendor_id = v1_vendor_id AND products_list_id = v1_products_list_id AND sub_category_id = v1_product_sub_category_id;

	    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,'A record is inserted into link_products_lists_vendors and a unique_id is generated, about a  nanosecond ago');

    ELSEIF v_COUNTLinksproductsVendorsID <> 0 AND v1_delete_flag = 0 THEN

       /* Select the count of links for this vendor_id and products_list_id from link_products_lists_vendors */
       SELECT unique_id INTO v1_unique_id
       FROM link_products_lists_vendors
       WHERE vendor_id = v1_vendor_id AND products_list_id = v1_products_list_id AND sub_category_id = v1_product_sub_category_id;

	UPDATE link_products_lists_vendors SET availability_id = v1_availability_id
	WHERE unique_id = v1_unique_id;

	    /* Unique ID is selected for the record and inserted in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,'Unique ID is selected for an already existing record, about a  nanosecond ago');

    END IF;


     END;
     SQL

  end

  def down

    execute "DROP PROCEDURE p_Insert_delete_uniqueid"

  end
end


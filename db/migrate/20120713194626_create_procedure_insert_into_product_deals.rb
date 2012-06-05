class CreateProcedureInsertIntoProductDeals < ActiveRecord::Migration
  def up

  
    execute <<-SQL
    CREATE PROCEDURE p_Insert_into_product_deals (IN v1_type VARCHAR(255),
						  IN v1_sub_category VARCHAR(255),
	                                          IN v1_product_name VARCHAR(255),
						  IN v1_identifier1 VARCHAR(255),
						  IN v1_identifier2 VARCHAR(255),
						  IN v1_business_type VARCHAR(255),
						  IN v1_vendor_id INT,
						  IN v1_deal_info TEXT,
						  IN v1_DebugId VARCHAR(255))
    BEGIN

	DECLARE v_sub_category_id, v_product_id, v_unique_id INT;

	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,concat("Subcategory value is ",v1_sub_category));

	IF v1_sub_category = "books" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given book deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "books_lists";

	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT books_list_id INTO v_product_id FROM books_lists
		WHERE f_stripstring(book_name) = f_stripstring(v1_product_name) AND f_stripstring(isbn13) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "mobiles" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given mobile deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "mobiles_lists";

		SELECT MAX(unique_id), products_list_id INTO v_unique_id, v_product_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id IN 
		(SELECT mobiles_list_id FROM mobiles_lists WHERE f_stripstring(mobile_name) = f_stripstring(v1_product_name)
		AND f_stripstring(mobile_brand) = f_stripstring(v1_identifier1)) AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_type = "insert" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Inserting a record into product_deals table");

	INSERT INTO product_deals(vendor_id, sub_category_id, product_id, business_type, unique_id, deal_info, created_at)
	VALUES(v1_vendor_id, v_sub_category_id, v_product_id, v1_business_type, v_unique_id, v1_deal_info,CURRENT_TIMESTAMP);

	ELSEIF v1_type = "update" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Updating a record in product_deals table");

	UPDATE product_deals SET vendor_id = v1_vendor_id, sub_category_id = v_sub_category_id, product_id = v_product_id,
	unique_id = v_unique_id, deal_info = v1_deal_info, updated_at = CURRENT_TIMESTAMP WHERE business_type = v1_business_type;

	ELSEIF v1_type = "delete" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Deleting a record from product_deals table");

	DELETE FROM product_deals WHERE vendor_id = v1_vendor_id;

	END IF;

    END
    SQL
  end

  def down
  	execute "DROP PROCEDURE p_Insert_into_product_deals"
  end
end

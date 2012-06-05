class CreateProcedureToInsertUpdateDeleteProductsTable < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Insert_update_delete_products_table"

    execute <<-SQL
    CREATE PROCEDURE p_Insert_update_delete_products_table(  IN v1_delete_flag INT,
                                                             IN v1_debug_id VARCHAR(255),
                                                             IN v1_type_flag VARCHAR(255),
                                                             IN v1_vendor_id INT,
                                                             IN v1_product_id INT,
                                                             IN v1_product_name VARCHAR(255),
                                                             IN v1_product_image_url TEXT,
                                                             IN v1_product_category VARCHAR(255),
                                                             IN v1_product_sub_category VARCHAR(255),
                                                             IN v1_product_identifier1 VARCHAR(255),
                                                             IN v1_product_identifier2 VARCHAR(255),
                                                             IN v1_product_price DOUBLE,
                                                             IN v1_product_availability VARCHAR(255),
                                                             IN v1_product_transport_cost DOUBLE,
                                                             IN v1_product_transport_time VARCHAR(255),
                                                             IN v1_product_special_offers TEXT,
							     IN v1_product_warranty TEXT,
                                                             IN v1_product_redirect_url TEXT,
                                                             IN v1_product_delivery CHAR(1),
                                                             IN v1_reason VARCHAR(255),
                                                             IN v1_validity VARCHAR(255),
                                                             IN v1_configured_by VARCHAR(255))


     BEGIN

    DECLARE v_COUNTProductsLists,v_products_list_id,v_availability_id, v_availability_count, v_fixed_flag INT;

    DECLARE v_UniqueID BIGINT;

    DECLARE v_message VARCHAR(255);

    /*After declaring v1_debug_id, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v1_debug_id);

	    call debug.debug_insert(v1_debug_id,'Calling the procedure p_Insertlog_selectcount_selectid');

   call p_Insertlog_selectcount_selectid( v1_configured_by,
                                          v1_reason,
                                          v1_validity,
					  v1_product_sub_category,
					  v1_product_name,
                                          v1_product_id,
                                          v1_vendor_id,
                                          v_COUNTProductsLists,
                                          v_products_list_id,
                                          v1_product_identifier1,
                                          v1_product_identifier2,
                                          v1_debug_id);

    IF v_COUNTProductsLists = 0 AND v1_delete_flag = 0 THEN

        SET v_message = "The product from part-1 is not present in part-2";

        call p_Insert_priority_errors(v1_product_sub_category,v1_product_name,v1_product_identifier1,v1_product_identifier2,v_message,v_fixed_flag,v1_debug_id);

        /* Insert a record in debug table for tracking the events */
	    call debug.debug_insert(v1_debug_id,'Stopped insert and given a priority error message - id not found in part2 db- to priority_errors table, about a  	nanosecond ago');

	call p_Insert_vendor_data_priorities(v1_vendor_id,v1_type_flag,v1_product_name,v1_product_identifier1,v1_product_identifier2,v_fixed_flag,v1_debug_id);

	/* Insert a record in debug table for tracking the events */
		    call debug.debug_insert(v1_debug_id,'Data, inserted in priority_errors table, has been updated in vendor_data_priorities table too');

   ELSE


/*  ##### building up part3 db which deals with features that are specific to both
the product and the vendors ##########  */

    call debug.debug_insert(v1_debug_id,concat('Availability value is, ',v1_product_availability));

    call p_Select_availability_id_and_count(v1_product_sub_category,v1_product_availability,v_availability_count,v_availability_id);

    call debug.debug_insert(v1_debug_id,concat('Availability id and count is, ',v_availability_id,' ',v_availability_count));
	
    IF v_availability_count = 0 AND v1_delete_flag = 0 THEN

        /* Stopping the insert and entering priority errors as
        the availability value passed is not in part-2 db */

        SET v_message = "The availability value from part-1 is not present in part-2";

        call p_Insert_priority_errors(v1_product_sub_category,v1_product_name,v1_product_identifier1,v1_product_identifier2,v_message,0,v1_debug_id);

           /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,'Stopped insert and given a priority error message - availability value not in part2 db- to priority_errors table, about a  nanosecond ago');

    ELSEIF v_availability_count = 0 AND v1_delete_flag = 1 THEN

        /* Stopping the insert and entering priority errors as
        the availability value passed is not in part-2 db */

        SET v_message = "This record, which already has a priority error set due to availability value missing in part-2, has been deleted";

        call p_Insert_priority_errors(v1_product_sub_category,v1_product_name,v1_product_identifier1,v1_product_identifier2,v_message,0,v1_debug_id);

           /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,'This record has been deleted - availability value not in part2 db- priority error message set, about a  nanosecond ago');

    ELSEIF  v_availability_count <> 0 THEN


   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,concat('Availability is present in part-2 as ',v1_product_availability,' and selected the availability_id as ',v_availability_id,' about a  nanosecond ago'));

    call p_build_part3(v1_product_sub_category,v1_vendor_id,v_products_list_id,v_availability_id,v1_debug_id,v1_delete_flag);


    /* ##########################  part3 build end s################################## */


        /* Passing the availability value to the gateway for
        selecting the availability_id */
        call p_gateway_of_crawlfish(v_products_list_id,
                                    v1_product_sub_category,
                                    v1_debug_id,
				    v1_product_name,
                                    v1_product_identifier1,
                                    v1_product_identifier2,
				    v1_delete_flag);



    /* Calling a stored procedure(SP) to insert the vendor_id and products_list_id into link_products_lists_vendors */
    /* and generate a unique_id which is an OUT variable */

    /* Passing the availability value to the procedure
    below to generate a uniqueid that links a vendor to a products_list_id and
    availability_id */
    call p_Insert_delete_uniqueid(  v1_debug_id,
				    v1_delete_flag,
				    v1_product_sub_category,
                                    v_products_list_id,
                                    v1_vendor_id,
                                    v_availability_id,
                                    v_UniqueID);



    IF v1_type_flag = 'online' THEN

  /* Calling a stored procedure(SP) to insert a record in online_grid_details with the unique_id */
    /* and details from online_*_products */
    call p_insert_update_delete_online_grid_details( v1_delete_flag,
                                              v_UniqueID,
                                              v1_product_price,
                                              v1_product_redirect_url,
                                              v1_product_transport_time,
                                              v1_product_transport_cost,
                                              v1_product_availability,
                                              v1_product_special_offers,
					      v1_product_warranty,
                                              v1_debug_id);
    ELSEIF v1_type_flag = 'local' THEN

    /* Calling a stored procedure(SP) to insert a record in online_grid_details with the unique_id */
    /* and details from local_*_products */
    call p_insert_update_delete_local_grid_details( v1_delete_flag,
                                              v_UniqueID,
                                              v1_product_price,
                                              v1_product_availability,
                                              v1_product_delivery,
                                              v1_product_transport_time,
                                              v1_product_transport_cost,
                                              v1_product_special_offers,
					      v1_product_warranty,
                                              v1_debug_id);

     END IF;


    END IF;

    END IF;
    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v1_debug_id);

    END;
    SQL
  end

  def down

    execute "DROP PROCEDURE p_Insert_update_delete_products_table"
  end
end


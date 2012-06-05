class CreateProcedureInsertUpdateDeleteOnlineGridDertails < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_Insert_update_delete_online_grid_details"

    execute <<-SQL
    CREATE PROCEDURE p_Insert_update_delete_online_grid_details(   IN v1_delete_flag INT,
                                                            IN v1_unique_id BIGINT(15),
                                                            IN v1_product_price DOUBLE,
                                                            IN v1_product_redirect_url TEXT,
                                                            IN v1_product_shipping_time VARCHAR(255),
                                                            IN v1_product_shipping_cost DOUBLE,
                                                            IN v1_product_availability VARCHAR(255),
                                                            IN v1_product_special_offers TEXT,
                                                            IN v1_product_warranty TEXT,
                                                            IN v1_debug_id VARCHAR(255))

     BEGIN

     DECLARE v_Count INT DEFAULT 0;

     SELECT COUNT(*)
     INTO v_Count
     FROM online_grid_details
     WHERE unique_id = v1_unique_id;

         IF  v_Count <> 0 AND v1_delete_flag = 1  THEN

            DELETE FROM online_grid_details
            WHERE unique_id = v1_unique_id;

            /* Insert a record in debug table for tracking the events */
            call debug.debug_insert(v1_debug_id,concat('Unique_id - ',v1_unique_id,', A record is deleted
            from online_grid_details, about a nanosecond ago'));


         ELSEIF v_Count = 0 AND v1_delete_flag = 0 THEN

         /* Inserting the values of vendor_id and books_list_id in to*/
         /*link_products_lists_vendors to create the link and this*/
         /*will generate a unique_id */
           INSERT INTO online_grid_details( unique_id,
                                            price,
                                            redirect_url,
                                            shipping_time,
                                            shipping_cost,
                                            availability,
                                            special_offers,
                                            warranty,
                                            created_at)
           VALUES(v1_unique_id,
                  v1_product_price,
                  v1_product_redirect_url,
                  v1_product_shipping_time,
                  v1_product_shipping_cost,
                  v1_product_availability,
                  v1_product_special_offers,
                  v1_product_warranty,
                  now());

          /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v1_debug_id,concat('Unique_id - ',v1_unique_id,', A record is inserted
                                into online_grid_details,about a nanosecond ago'));
         ELSEIF v_Count <> 0 AND v1_delete_flag = 0 THEN

         UPDATE online_grid_details SET price=v1_product_price,
                                        redirect_url = v1_product_redirect_url,
                                        shipping_time = v1_product_shipping_time,
                                        shipping_cost = v1_product_shipping_cost,
                                        availability = v1_product_availability,
                                        special_offers = v1_product_special_offers,
                                        warranty = v1_product_warranty,
                                        updated_at = now()

         WHERE unique_id = v1_unique_id;

          /* Insert a record in debug table for tracking the events */
        call debug.debug_insert(v1_debug_id,concat('Unique_id - ',v1_unique_id,', A record is updated
                                into online_grid_details,about a nanosecond ago'));

          END IF;

    END;
    SQL
  end

  def down

    execute "DROP PROCEDURE p_Insert_update_delete_online_grid_details"

  end
end


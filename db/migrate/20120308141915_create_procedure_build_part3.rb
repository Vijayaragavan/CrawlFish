class CreateProcedureBuildPart3 < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_build_part3"

    execute <<-SQL
    CREATE PROCEDURE p_build_part3(IN v2_product_sub_category VARCHAR(255),
				   IN v2_vendor_id INT,
                                   IN v2_products_list_id INT,
                                   IN v2_availability_id INT,
                                   IN v2_debug_id VARCHAR(255),
				   IN v2_delete_flag INT)
    BEGIN


    DECLARE v_Count INT;


    IF v2_delete_flag = 0 THEN

    IF v2_product_sub_category = "books_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f10_vendor_books_lists
     WHERE vendor_id = v2_vendor_id AND books_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f10_vendor_books_lists(  vendor_id,
                                        books_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and books_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f10_vendor_books_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND books_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and books_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "mobiles_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f16_vendor_mobiles_lists
     WHERE vendor_id = v2_vendor_id AND mobiles_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f16_vendor_mobiles_lists(  vendor_id,
                                        mobiles_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and mobiles_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f16_vendor_mobiles_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND mobiles_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and mobiles_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

    END IF;

     END;

    SQL
  end

  def down

    execute "DROP PROCEDURE p_build_part3"

  end
end


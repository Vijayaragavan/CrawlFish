class CreateProcedureSelectAvailabilityIdAndCount < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Select_availability_id_and_count"

    execute <<-SQL
    CREATE PROCEDURE p_Select_availability_id_and_count(IN v2_product_sub_category VARCHAR(255),
					      IN v2_product_availability VARCHAR(255),
                                              OUT v1_availability_count INT,
					      OUT v1_availability_id INT)
    BEGIN

    IF v2_product_sub_category = "books_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM books_vendor_f10_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "mobiles_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM mobiles_vendor_f16_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

  END;

  SQL

  end

  def down

   execute "DROP PROCEDURE p_Select_availability_id_and_count"

  end
end

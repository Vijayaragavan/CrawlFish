class CreateProcedureInsertVendorDataPriorities < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_Insert_vendor_data_priorities"

    execute <<-SQL
    CREATE PROCEDURE p_Insert_vendor_data_priorities(IN v2_vendor_id INT, IN v2_type_flag VARCHAR(255), IN v2_product_name VARCHAR(255),
						IN v2_product_identifier1 VARCHAR(255), IN v2_product_identifier2 VARCHAR(255),
						IN v1_fixed_flag INT, IN v2_debug_id VARCHAR(255))
	BEGIN

	DECLARE v_vendor_table_name,v_vendor_name,v_city_name,v_branch_name VARCHAR(255);

	/*After declaring v2_debug_id, the debug_on procedure is called which is insert a record in debug table */
	call debug.debug_on(v2_debug_id);

	SELECT vendor_name, city_name, branch_name INTO v_vendor_name, v_city_name, v_branch_name
	FROM vendors_lists WHERE vendor_id=v2_vendor_id;

	IF v2_type_flag = "online" THEN
	SET v_vendor_table_name = CONCAT(LOWER(v2_type_flag),'_',LOWER(v_vendor_name),'_products');
	ELSE
	SET v_vendor_table_name = CONCAT(LOWER(v2_type_flag),'_',LOWER(v_city_name),'_',LOWER(v_branch_name),'_',LOWER(v_vendor_name),'_products');
	END IF;	


	INSERT INTO vendor_data_priorities(vendor_table_name,product_name,product_identifier1,
	product_identifier2,priority_errors_flag,created_at)
	VALUE(v_vendor_table_name,v2_product_name,v2_product_identifier1,v2_product_identifier2,
	v1_fixed_flag,now());

	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v2_debug_id,'Record inserted into vendor_data_priorities table');

	/* Ending the debug table insert with a #(pound) mark */
	call debug.debug_off(v2_debug_id);

	END
    SQL
  end

  def down
    execute "DROP PROCEDURE p_Insert_vendor_data_priorities"
  end
end

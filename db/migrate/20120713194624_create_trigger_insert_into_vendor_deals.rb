class CreateTriggerInsertIntoVendorDeals < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_insert_vendor_deals"
    execute "DROP TRIGGER IF EXISTS t_update_vendor_deals"

    execute <<-SQL
    CREATE TRIGGER t_insert_vendor_deals AFTER INSERT ON vendor_deals
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_insert_vendor_deals';
    DECLARE v_vendor_id INT;


    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF new.business_type = "online" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(new.vendor_name);

    ELSEIF new.business_type = "local" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(new.vendor_name) AND
	f_stripstring(city_name) = f_stripstring(new.city_name) AND f_stripstring(branch_name) = f_stripstring(new.branch_name);

    END IF;	

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Vendor Id has been found");

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Calling the procedure to insert deals info into product deals table");

	call p_Insert_into_product_deals("insert", new.sub_category, new.product_name, new.identifier1, new.identifier2, new.business_type, v_vendor_id, new.deal_info, v_DebugId);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_update_vendor_deals AFTER UPDATE ON vendor_deals
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_update_vendor_deals';
    DECLARE v_vendor_id INT;


    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF new.business_type = "online" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(new.vendor_name);

    ELSEIF new.business_type = "local" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(new.vendor_name) AND
	f_stripstring(city_name) = f_stripstring(new.city_name) AND f_stripstring(branch_name) = f_stripstring(new.branch_name);

    END IF;	

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Vendor Id has been found");

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Calling the procedure to update deals info in product deals table");

	call p_Insert_into_product_deals("update", new.sub_category, new.product_name, new.identifier1, new.identifier2, new.business_type, v_vendor_id, new.deal_info, v_DebugId);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

    execute <<-SQL
    CREATE TRIGGER t_delete_vendor_deals AFTER DELETE ON vendor_deals
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_delete_vendor_deals';
    DECLARE v_vendor_id INT;


    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

    IF old.business_type = "online" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(old.vendor_name);

    ELSEIF old.business_type = "local" THEN

	SELECT vendor_id INTO v_vendor_id FROM vendors_lists
	WHERE f_stripstring(vendor_name) = f_stripstring(old.vendor_name) AND
	f_stripstring(city_name) = f_stripstring(old.city_name) AND f_stripstring(branch_name) = f_stripstring(old.branch_name);

    END IF;	

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Vendor Id has been found");

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Calling the procedure to delete deals info from product deals table");

	call p_Insert_into_product_deals("delete", old.sub_category, old.product_name, old.identifier1, old.identifier2, old.business_type, v_vendor_id, old.deal_info, v_DebugId);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

  end

  def down
    execute "DROP TRIGGER t_insert_vendor_deals"
    execute "DROP TRIGGER t_update_vendor_deals"
    execute "DROP TRIGGER t_delete_vendor_deals"
  end
end

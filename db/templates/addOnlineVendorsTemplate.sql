class Create<<class_vendor_type>><<class_vendor_name>>Products < ActiveRecord::Migration

  def up

      execute <<-SQL

  INSERT INTO vendors_lists(vendor_name,vendor_logo,vendor_description,business_type,vendor_website,vendor_email,vendor_phone,vendor_fax,
vendor_address,latitude,longitude,city_name,branch_name,working_time,miscellaneous,vendor_sub_categories,monetization_type,subscribed_date,created_at) values('<<capitalized_vendor_name>>','<<vendor_logo>>','<<vendor_description>>','<<business_type>>','<<vendor_website>>','<<vendor_email>>','<<vendor_phone>>','<<vendor_fax>>', '<<vendor_address>>','<<latitude>>','<<longitude>>','<<city_name>>','<<branch_name>>','<<working_time>>','<<miscellaneous>>',
'<<sub_categories>>','<<monetization_type>>','<<subscribed_date>>',now());

	SQL

  execute <<-SQL

  CREATE TABLE IF NOT EXISTS <<business_type>>_<<vendor_name>>_products (
  product_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  product_image_url TEXT,
  product_category VARCHAR(255) NOT NULL,
  product_sub_category VARCHAR(255) NOT NULL,
  product_identifier1 VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) NOT NULL,
  product_price DOUBLE NOT NULL,
  product_shipping_cost DOUBLE NOT NULL,
  product_shipping_time VARCHAR(255) NOT NULL,
  product_availability VARCHAR (255) NOT NULL,
  product_redirect_url TEXT NOT NULL,
  product_special_offers TEXT,
  product_warranty TEXT,
  reason VARCHAR(255) NOT NULL,
  validity VARCHAR(255) NOT NULL,
  configured_by VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (product_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

    execute <<-SQL

    CREATE TRIGGER t_Insert_<<business_type>>_<<vendor_name>>_products AFTER INSERT ON <<business_type>>_<<vendor_name>>_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_sub_category_id INT(3);

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT '<<business_type>>';

    DECLARE v_DebugID VARCHAR(255);



	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='<<vendor_name>>';

	SET v_DebugID = concat('ionlinev',v_VendorID,'p',new.product_id);






        call p_insert_update_delete_products_table(   v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     new.product_id,
                                                     new.product_name,
                                                     new.product_image_url,
						     new.product_category,
						     new.product_sub_category,
						     new.product_identifier1,
						     new.product_identifier2,
                                                     new.product_price,
  						     new.product_availability,
                                                     new.product_shipping_cost,
                                                     new.product_shipping_time,
						     new.product_special_offers,
						     new.product_warranty,
						     new.product_redirect_url,
						     NULL,
						     new.reason,
						     new.validity,
						     new.configured_by);
    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Update_<<business_type>>_<<vendor_name>>_products AFTER UPDATE ON <<business_type>>_<<vendor_name>>_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT '<<business_type>>';

    DECLARE v_DebugID VARCHAR(255);

	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='<<vendor_name>>';

SET v_DebugID = concat('uonlinev',v_VendorID,'p',new.product_id);

  call p_insert_update_delete_products_table(  v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     new.product_id,
                                                     new.product_name,
                                                     new.product_image_url,
						     new.product_category,
						     new.product_sub_category,
						     new.product_identifier1,
						     new.product_identifier2,
                                                     new.product_price,
  						     new.product_availability,
                                                     new.product_shipping_cost,
                                                     new.product_shipping_time,
						     new.product_special_offers,
						     new.product_warranty,
						     new.product_redirect_url,
						     NULL,
						     new.reason,
						     new.validity,
						     new.configured_by);


    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Delete_<<business_type>>_<<vendor_name>>_products BEFORE DELETE ON <<business_type>>_<<vendor_name>>_products
    FOR EACH ROW
    BEGIN


    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 1;

    DECLARE v_type_flag VARCHAR(255) DEFAULT '<<business_type>>';

    DECLARE v_DebugID VARCHAR(255);


	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='<<vendor_name>>';

	SET v_DebugID = concat('donlinev',v_VendorID,'p',old.product_id);

 call p_insert_update_delete_products_table(    v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     old.product_id,
                                                     old.product_name,
                                                     old.product_image_url,
						     old.product_category,
						     old.product_sub_category,
						     old.product_identifier1,
						     old.product_identifier2,
                                                     old.product_price,
  						     old.product_availability,
                                                     old.product_shipping_cost,
                                                     old.product_shipping_time,
						     old.product_special_offers,
						     old.product_warranty,
						     old.product_redirect_url,
						     NULL,
						     old.reason,
						     old.validity,
						     old.configured_by);


    END;

    SQL

  end



  def down

	execute "DELETE FROM <<business_type>>_<<vendor_name>>_products"
	execute "call p_drop_online_vendor('<<vendor_name>>')"
        execute "DROP TRIGGER t_Delete_<<business_type>>_<<vendor_name>>_products"
        execute "DROP TRIGGER t_Update_<<business_type>>_<<vendor_name>>_products"
        execute "DROP TRIGGER t_Insert_<<business_type>>_<<vendor_name>>_products"
        execute "DROP TABLE <<business_type>>_<<vendor_name>>_products"
        system "rails destroy model <<business_type>>_<<vendor_name>>_products"
  end
end


class CreateLocalChennaiVelacheryBlazersProducts < ActiveRecord::Migration

  def up

      execute <<-SQL

  INSERT INTO vendors_lists(vendor_name,vendor_logo,vendor_description,business_type,vendor_website,vendor_email,vendor_phone,vendor_fax,
vendor_address,latitude,longitude,city_name,branch_name,working_time,miscellaneous,vendor_sub_categories,monetization_type,subscribed_date,created_at) values('Blazers','na','Good mobile shop','local','na','sayar-mobiles@gmail.com','128712','457633344', 'mambalam, chennai-24','128.083','56.098','chennai','velachery','9AM to 8.30PM','na',
'books_lists,mobiles_lists','variable','2012-05-14',now());

    SQL


  execute <<-SQL

  CREATE TABLE IF NOT EXISTS local_chennai_velachery_blazers_products (
  product_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  product_image_url TEXT,
  product_category VARCHAR(255) NOT NULL,
  product_sub_category VARCHAR(255) NOT NULL,
  product_identifier1 VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) NOT NULL,
  product_price DOUBLE NOT NULL,
  product_availability VARCHAR(255) NOT NULL,
  product_delivery CHAR(1) NOT NULL,
  product_delivery_time VARCHAR(255),
  product_delivery_cost DOUBLE DEFAULT "0",
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
    CREATE TRIGGER t_Insert_local_chennai_velachery_blazers_products AFTER INSERT ON local_chennai_velachery_blazers_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'local';

    DECLARE v_DebugID VARCHAR(255);

    SELECT vendor_id INTO v_VendorID FROM vendors_lists where vendor_name='blazers' AND branch_name='velachery';

	SET v_DebugID = concat('ilocalv',v_VendorID,'p',new.product_id);

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
                                                     new.product_delivery_cost,
                                                     new.product_delivery_time,
						     new.product_special_offers,
						     new.product_warranty,
						     NULL,
						     new.product_delivery,
						     new.reason,
						     new.validity,
						     new.configured_by);

    END;

    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_local_chennai_velachery_blazers_products AFTER UPDATE ON local_chennai_velachery_blazers_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'local';

    DECLARE v_DebugID VARCHAR(255);

    SELECT vendor_id INTO v_VendorID FROM vendors_lists where vendor_name='blazers' AND branch_name='velachery';

	SET v_DebugID = concat('ulocalv',v_VendorID,'p',new.product_id);

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
                                                     new.product_delivery_cost,
                                                     new.product_delivery_time,
						     new.product_special_offers,
						     new.product_warranty,
						     NULL,
						     new.product_delivery,
						     new.reason,
						     new.validity,
						     new.configured_by);
    END;

    SQL
    execute <<-SQL
    CREATE TRIGGER t_Delete_local_chennai_velachery_blazers_products BEFORE DELETE ON local_chennai_velachery_blazers_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 1;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'local';

    DECLARE v_DebugID VARCHAR(255);

    SELECT vendor_id INTO v_VendorID FROM vendors_lists where vendor_name='blazers' AND branch_name='velachery';

	SET v_DebugID = concat('dlocalv',v_VendorID,'p',old.product_id);

       call p_insert_update_delete_products_table(   v_delete_flag,
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
                                                     old.product_delivery_cost,
                                                     old.product_delivery_time,
						     old.product_special_offers,
						     old.product_warranty,
						     NULL,
						     old.product_delivery,
						     old.reason,
						     old.validity,
						     old.configured_by);
    END;

    SQL






  end


  def down

        execute "DELETE FROM local_chennai_velachery_blazers_products"
        execute "call p_drop_local_vendor('blazers','chennai','velachery')"
        execute "DROP TRIGGER t_Delete_local_chennai_velachery_blazers_products"
        execute "DROP TRIGGER t_Update_local_chennai_velachery_blazers_products"
        execute "DROP TRIGGER t_Insert_local_chennai_velachery_blazers_products"
        execute "DROP TABLE local_chennai_velachery_blazers_products"
        system "rails destroy model local_chennai_velachery_blazers_products"
  end
end


class CreateVendorsLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendors_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendors_lists (
  vendor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  vendor_name VARCHAR(255) NOT NULL,
  vendor_logo TEXT NOT NULL,
  vendor_description TEXT NOT NULL,
  business_type VARCHAR(255) NOT NULL,
  vendor_website VARCHAR(255) DEFAULT "na",
  vendor_email VARCHAR(255) NOT NULL,
  vendor_phone VARCHAR(255) NOT NULL,
  vendor_fax VARCHAR(255) DEFAULT "na",
  vendor_address TEXT NOT NULL,
  latitude VARCHAR(255) DEFAULT "na",
  longitude VARCHAR(255) DEFAULT "na",
  city_name VARCHAR(255) NOT NULL,
  branch_name VARCHAR(255) NOT NULL,
  working_time TEXT,
  miscellaneous TEXT,
  vendor_sub_categories VARCHAR(500) NOT NULL,
  monetization_type VARCHAR(255) NOT NULL,
  subscribed_date DATE NOT NULL,
  vendor_rating INT UNSIGNED DEFAULT "0",
  blocked_flag INT UNSIGNED DEFAULT "0",
  discarded_flag INT UNSIGNED 	DEFAULT "0",
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (vendor_id),
  UNIQUE (vendor_name,business_type,city_name,branch_name),
  UNIQUE (vendor_phone)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendors_lists"
  end
end


class CreateMerchantsLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS merchants_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS merchants_lists (
  merchants_list_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  merchant_name VARCHAR(255) NOT NULL,
  merchant_logo TEXT NOT NULL,
  merchant_description TEXT,
  business_type VARCHAR(255) NOT NULL,
  merchant_website VARCHAR(255) NOT NULL,
  merchant_email VARCHAR(255) NOT NULL,
  merchant_phone VARCHAR(255) NOT NULL,
  merchant_fax VARCHAR(255) DEFAULT "na",
  merchant_address TEXT NOT NULL,
  latitude VARCHAR(255) DEFAULT "na",
  longitude VARCHAR(255) DEFAULT "na",
  city_name VARCHAR(255),
  branch_name VARCHAR(255),
  merchant_id INT UNSIGNED ,
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (merchants_list_id),
  UNIQUE (merchant_name,business_type,city_name,branch_name),
  UNIQUE (merchant_phone),
  UNIQUE (merchant_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS merchants_lists"
  end
end


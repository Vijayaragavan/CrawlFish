class CreateVendorDeals < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendor_deals"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_deals (
  id INT UNSIGNED AUTO_INCREMENT,
  sub_category VARCHAR(255) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  identifier1 VARCHAR(255),
  identifier2 VARCHAR(255),
  vendor_name VARCHAR(255) NOT NULL,
  business_type VARCHAR(255) NOT NULL,
  city_name VARCHAR(255) NOT NULL,
  branch_name VARCHAR(255) NOT NULL,
  deal_info TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendor_deals"
  end
end


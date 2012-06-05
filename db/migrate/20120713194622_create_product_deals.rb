class CreateProductDeals < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS product_deals"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS product_deals (
  id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT NOT NULL,
  sub_category_id INT NOT NULL,
  product_id INT NOT NULL,
  unique_id INT NOT NULL,
  business_type VARCHAR(255),
  deal_info TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE product_deals"
  end
end


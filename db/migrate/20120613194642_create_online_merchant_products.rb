class CreateOnlineMerchantProducts < ActiveRecord::Migration
  def up

  execute <<-SQL

      CREATE TABLE online_merchant_products (
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
      part1_product_id INT UNSIGNED NOT NULL,
      vendor_id INT UNSIGNED NOT NULL,
      vendor_table_name VARCHAR(255) NOT NULL,
      action VARCHAR(255) NOT NULL,
      PRIMARY KEY (product_id)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS online_merchant_products"

  end
end


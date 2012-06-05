class CreateProductPurchaseCommissionVendors < ActiveRecord::Migration
  def up
 
  execute "DROP TABLE IF EXISTS product_purchase_commission_vendors"
  
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS product_purchase_commission_vendors (
  id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  purchase_commission INT UNSIGNED NOT NULL,
  subscribed_date DATE NOT NULL,
  cut_off_amount DOUBLE NOT NULL,
  cut_off_period INT UNSIGNED NOT NULL,
  history_flag INT UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (vendor_id,sub_category_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

  end

  def down
  execute "DROP TABLE product_purchase_commission_vendors" 
  end
end

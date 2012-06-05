class CreateVendorProductPurchasesLogs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendor_product_purchases_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_product_purchases_logs (
  v_p_purch_log_id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_purchase_count INT UNSIGNED NOT NULL,
  product_purchase_amount DOUBLE UNSIGNED NOT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (v_p_purch_log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendor_product_purchases_logs"
  end
end

class CreateVendorProductTransactionsLogs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendor_product_transactions_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_product_transactions_logs (
  v_p_trans_log_id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  page_impressions_count INT UNSIGNED NOT NULL,
  button_clicks_count INT UNSIGNED NOT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (v_p_trans_log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendor_product_transactions_logs"
  end
end

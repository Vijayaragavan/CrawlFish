class CreateVendorsConfigLogs < ActiveRecord::Migration
  
  def up
  execute "DROP TABLE IF EXISTS vendors_config_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendors_config_logs (
  log_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  configured_by VARCHAR(255) NOT NULL,
  reason VARCHAR(255) NOT NULL,
  validity VARCHAR(255) NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendors_config_logs"
  end

end

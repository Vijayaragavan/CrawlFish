class CreateMerchants < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS merchants"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS merchants (
  merchant_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  login_name VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  password_salt VARCHAR(255) NOT NULL,
  table_name VARCHAR(255) NULL,
  business_type VARCHAR(255) NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (merchant_id),
  UNIQUE (login_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS merchants"
  end
end


class CreateMerchantsPasswordRequests < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS merchants_password_requests"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS merchants_password_requests (
  request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  request TEXT NOT NULL,
  request_type VARCHAR(255) NOT NULL,
  merchant_id INT UNSIGNED NOT NULL,
  served INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (request_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS merchants_password_requests"
  end
end

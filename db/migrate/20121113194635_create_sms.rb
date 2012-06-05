class CreateSms < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS sms"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS sms (
  sms_id INT UNSIGNED AUTO_INCREMENT,
  product_id INT NOT NULL,
  sub_category_id INT NOT NULL,
  vendor_id INT NOT NULL,
  landline_number VARCHAR(255) DEFAULT 'NA',
  mobile_number VARCHAR(255) DEFAULT 'NA',
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (sms_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE sms"
  end
end


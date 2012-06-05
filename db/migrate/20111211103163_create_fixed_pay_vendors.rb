class CreateFixedPayVendors < ActiveRecord::Migration
  def up
 
  execute "DROP TABLE IF EXISTS fixed_pay_vendors"
  
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS fixed_pay_vendors (
  id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  accepted_amount DOUBLE NOT NULL,
  subscribed_date DATE NOT NULL,
  cut_off_period INT UNSIGNED NOT NULL,
  history_flag INT UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (vendor_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

  end

  def down
  execute "DROP TABLE fixed_pay_vendors" 
  end
end

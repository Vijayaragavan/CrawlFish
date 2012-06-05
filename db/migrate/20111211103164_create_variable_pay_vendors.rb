class CreateVariablePayVendors < ActiveRecord::Migration
  def up
 
  execute "DROP TABLE IF EXISTS variable_pay_vendors"
  
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS variable_pay_vendors (
  id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  accepted_impressions_rate DOUBLE NOT NULL,
  accepted_button_click_rate DOUBLE NOT NULL,
  subscribed_date DATE NOT NULL,
  cut_off_amount DOUBLE NOT NULL,
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
  execute "DROP TABLE variable_pay_vendors" 
  end
end

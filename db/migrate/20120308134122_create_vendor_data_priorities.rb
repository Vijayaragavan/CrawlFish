class CreateVendorDataPriorities < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendor_data_priorities"	   

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_data_priorities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  vendor_table_name VARCHAR(255) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  product_identifier1 VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) NOT NULL,
  priority_errors_flag INT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

  end

  def down
	execute "DROP TABLE vendor_data_priorities"
  end
end

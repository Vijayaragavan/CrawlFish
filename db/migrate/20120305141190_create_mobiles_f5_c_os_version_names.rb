class CreateMobilesF5COsVersionNames < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f5_c_os_version_names"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f5_c_os_version_names (
  mobile_os_version_name_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_os_version_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_os_version_name_id),
  UNIQUE(mobile_os_version_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f5_c_os_version_names"
  end
end

class CreateMobilesF5OsVersions < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f5_os_versions"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f5_os_versions (
  mobile_os_version_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_os_version VARCHAR(255) NOT NULL,
  mobile_os_version_name_id INT DEFAULT "0",
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_os_version_id),
  UNIQUE(mobile_os_version,mobile_os_version_name_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f5_os_versions"
  end
end

class CreateMobilesF3MobileTypes < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f3_mobile_types"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f3_mobile_types (
  mobile_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_type_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_type_id),
  UNIQUE(mobile_type_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f3_mobile_types"
  end
end

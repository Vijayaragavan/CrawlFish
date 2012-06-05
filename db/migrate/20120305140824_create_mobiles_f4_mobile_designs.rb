class CreateMobilesF4MobileDesigns < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f4_mobile_designs"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f4_mobile_designs (
  mobile_design_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_design_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_design_id),
  UNIQUE(mobile_design_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f4_mobile_designs"
  end
end

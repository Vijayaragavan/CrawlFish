class CreateMobilesF14MobileRams < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f14_mobile_rams"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f14_mobile_rams (
  mobile_ram_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_ram VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_ram_id),
  UNIQUE(mobile_ram)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f14_mobile_rams"
  end
end

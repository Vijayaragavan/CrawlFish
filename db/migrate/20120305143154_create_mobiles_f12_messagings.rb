class CreateMobilesF12Messagings < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f12_messagings"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f12_messagings (
  messaging_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  messaging_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (messaging_id),
  UNIQUE(messaging_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f12_messagings"
  end
end

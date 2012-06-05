class CreateMobilesF7InternalStorages < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f7_internal_storages"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f7_internal_storages (
  internal_storage_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  internal_storage_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (internal_storage_id),
  UNIQUE(internal_storage_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f7_internal_storages"
  end
end

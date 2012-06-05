class CreateMobilesF10SecondaryCameras < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f10_secondary_cameras"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f10_secondary_cameras (
  secondary_camera_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  secondary_camera VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (secondary_camera_id),
  UNIQUE(secondary_camera)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f10_secondary_cameras"
  end
end

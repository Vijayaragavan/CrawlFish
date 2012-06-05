class CreateMobilesF9PrimaryCameras < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f9_primary_cameras"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f9_primary_cameras (
  primary_camera_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  primary_camera VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (primary_camera_id),
  UNIQUE(primary_camera)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f9_primary_cameras"
  end
end

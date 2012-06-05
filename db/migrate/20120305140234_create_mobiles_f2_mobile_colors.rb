class CreateMobilesF2MobileColors < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f2_mobile_colors"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f2_mobile_colors (
  mobile_color_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_color_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_color_id),
  UNIQUE(mobile_color_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f2_mobile_colors"
  end
end

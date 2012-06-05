class CreateMobilesF6TouchScreens < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f6_touch_screens"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f6_touch_screens (
  touch_screen_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  touch_screen_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (touch_screen_id),
  UNIQUE(touch_screen_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f6_touch_screens"
  end
end

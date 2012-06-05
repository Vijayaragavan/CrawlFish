class CreateMobilesF13Browsers < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f13_browsers"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f13_browsers (
  browser_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  browser_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (browser_id),
  UNIQUE(browser_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f13_browsers"
  end
end

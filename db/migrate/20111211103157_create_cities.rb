class CreateCities < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS cities"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS cities (
  city_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (city_id),
  UNIQUE (city_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE cities"
  end
end

class CreateMobilesF15Assorteds < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f15_assorteds"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f15_assorteds (
  assorteds_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  assorteds_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (assorteds_id),
  UNIQUE(assorteds_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f15_assorteds"
  end
end

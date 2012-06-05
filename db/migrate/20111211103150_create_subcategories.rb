class CreateSubcategories < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS subcategories"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS subcategories (
  sub_category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  sub_category_name VARCHAR(255) NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  category_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (sub_category_id),
  UNIQUE (category_name,sub_category_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE subcategories"
  end
end

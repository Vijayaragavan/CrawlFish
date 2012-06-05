class CreateMetaTags < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS metatags"	   

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS metatags (
  metatag_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  metatag VARCHAR(255) NOT NULL,
  model_name VARCHAR(255) NOT NULL,
  column_name VARCHAR(255) NOT NULL,
  primary_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (metatag_id),
  UNIQUE (model_name,column_name,primary_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

  end

  def down
	execute "DROP TABLE metatags"
  end
end

class CreateBooksF9Languages < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f9_languages"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f9_languages (
  language_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  language_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (language_id),
  UNIQUE (language_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f9_languages"
  end
end

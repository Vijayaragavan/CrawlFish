class CreateBooksF1Authors < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f1_authors"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f1_authors (
  author_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (author_id),
  UNIQUE (author_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1; 
  SQL
  end

  def down
  execute "DROP TABLE books_f1_authors"
  end
end


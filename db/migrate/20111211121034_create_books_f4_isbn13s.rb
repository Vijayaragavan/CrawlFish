class CreateBooksF4Isbn13s < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f4_isbn13s"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f4_isbn13s (
  isbn13_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  isbn13 VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (isbn13_id),
  UNIQUE (isbn13)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f4_isbn13s"
  end
end


class CreateBooksF3Isbns < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f3_isbns"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f3_isbns (
  isbn_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  isbn VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (isbn_id),
  UNIQUE (isbn)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f3_isbns"
  end
end

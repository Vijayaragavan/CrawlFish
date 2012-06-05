class CreateLinkF2BooksLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS link_f2_books_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_f2_books_lists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  books_list_id INT UNSIGNED NOT NULL,
  genre_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (books_list_id,genre_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE link_f2_books_lists"
  end
end

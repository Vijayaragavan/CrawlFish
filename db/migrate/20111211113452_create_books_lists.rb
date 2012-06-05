class CreateBooksLists < ActiveRecord::Migration
  def up
    execute "DROP TABLE IF EXISTS books_lists"
    
    execute <<-SQL
    CREATE TABLE books_lists (
      books_list_id INT UNSIGNED AUTO_INCREMENT,
      book_name VARCHAR(255) NOT NULL,
      book_image_url TEXT DEFAULT NULL,
      book_features TEXT NOT NULL,
      isbn VARCHAR(255) NOT NULL,
      isbn13 VARCHAR(255) NOT NULL,
      created_at DATETIME NOT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (books_list_id),
      UNIQUE(isbn,isbn13)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    SQL

    end
  def down
    execute "DROP TABLE books_lists"
  end
end


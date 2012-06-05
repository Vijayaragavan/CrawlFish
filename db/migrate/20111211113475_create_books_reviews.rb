class CreateBooksReviews < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_reviews"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_reviews (
  id INT UNSIGNED AUTO_INCREMENT,
  isbn VARCHAR(255) NOT NULL,
  isbn13 VARCHAR(255) NOT NULL,
  description TEXT,
  average_rating DOUBLE NOT NULL,
  script TEXT,
  miscellaneous TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE books_reviews"
  end
end


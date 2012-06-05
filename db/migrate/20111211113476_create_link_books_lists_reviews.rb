class CreateLinkBooksListsReviews < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS link_books_lists_reviews"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_books_lists_reviews (
  id INT UNSIGNED AUTO_INCREMENT,
  books_list_id INT UNSIGNED NOT NULL,
  books_reviews_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX (books_list_id),
  INDEX (books_reviews_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE link_books_lists_reviews"
  end
end


class CreateBooksF2Genres < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f2_genres"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f2_genres (
  genre_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  genre_name VARCHAR(255) NOT NULL,
  level_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (genre_id),
  UNIQUE (genre_name,level_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE books_f2_genres"
  end
end

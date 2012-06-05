class CreateBooksF7Publishers < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f7_publishers"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f7_publishers (
  publisher_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  publisher VARCHAR(255) NOT NULL,
  publisher_alias VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (publisher_id),
  UNIQUE (publisher)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f7_publishers"
  end
end


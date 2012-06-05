class CreateBooksF8Editions < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f8_editions"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f8_editions (
  edition_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  edition_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (edition_id),
  UNIQUE (edition_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE books_f8_editions"
  end
end

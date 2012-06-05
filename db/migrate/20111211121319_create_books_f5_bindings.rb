class CreateBooksF5Bindings < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f5_bindings"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_f5_bindings (
  binding_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  binding_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (binding_id),
  UNIQUE (binding_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f5_bindings"
  end
end

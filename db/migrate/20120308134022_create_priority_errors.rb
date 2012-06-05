class CreatePriorityErrors < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS priority_errors"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS priority_errors (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  product_sub_category VARCHAR(255) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  identifier1 VARCHAR(255) NOT NULL,
  identifier2 VARCHAR(255) NOT NULL,
  message TEXT,
  count INT,
  fixed INT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE priority_errors"
  end
end


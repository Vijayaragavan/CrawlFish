class CreateBranches < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS branches"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS branches (
  branch_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city_id INT UNSIGNED NOT NULL,
  branch_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (branch_id),
  UNIQUE (branch_name,city_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE branches"
  end
end

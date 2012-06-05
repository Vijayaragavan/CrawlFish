class CreatePriorityRequests < ActiveRecord::Migration
 def up

  execute "DROP TABLE IF EXISTS priority_requests"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS priority_requests (
  request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  request TEXT NOT NULL,
  request_type VARCHAR(255) NOT NULL,
  merchants_list_id INT UNSIGNED NOT NULL,
  served INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (request_id),
  UNIQUE (merchants_list_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS priority_requests"
  end
end


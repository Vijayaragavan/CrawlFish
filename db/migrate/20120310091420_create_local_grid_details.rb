class CreateLocalGridDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS local_grid_details"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS local_grid_details (
  unique_id BIGINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  price DOUBLE NOT NULL,
  availability VARCHAR(255) NOT NULL,
  delivery CHAR(1) NOT NULL,
  delivery_time VARCHAR(255),
  delivery_cost DOUBLE,
  special_offers TEXT,
  warranty TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (unique_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1  ;
  SQL
  end

  def down
  execute "DROP TABLE local_grid_details"
  end
end


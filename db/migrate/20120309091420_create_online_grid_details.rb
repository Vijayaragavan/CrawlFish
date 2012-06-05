class CreateOnlineGridDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS online_grid_details"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS online_grid_details (
  unique_id BIGINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  price DOUBLE NOT NULL,
  redirect_url TEXT NOT NULL,
  shipping_time VARCHAR(255) NOT NULL,
  shipping_cost DOUBLE NOT NULL,
  availability VARCHAR(255) NOT NULL,
  special_offers TEXT,
  warranty TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (unique_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE online_grid_details"
  end
end


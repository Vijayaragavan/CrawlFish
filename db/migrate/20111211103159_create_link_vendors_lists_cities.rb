class CreateLinkVendorsListsCities < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS link_vendors_lists_cities"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_vendors_lists_cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (vendor_id,city_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE link_vendors_lists_cities"
  end
end

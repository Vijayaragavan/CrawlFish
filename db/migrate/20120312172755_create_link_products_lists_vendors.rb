class CreateLinkProductsListsVendors < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS link_products_lists_vendors"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_products_lists_vendors (
  unique_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  products_list_id INT UNSIGNED NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  availability_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (unique_id),
  UNIQUE (vendor_id,products_list_id,sub_category_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE link_products_lists_vendors"
  end
end


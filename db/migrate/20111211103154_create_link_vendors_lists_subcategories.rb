class CreateLinkVendorsListsSubcategories < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS link_vendors_lists_sub_categories"

    execute <<-SQL
    CREATE TABLE IF NOT EXISTS link_vendors_lists_sub_categories (
    link_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    sub_category_id INT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (link_id),
    UNIQUE (vendor_id,sub_category_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down

  execute "DROP TABLE link_vendors_lists_sub_categories"  
 
  end
end

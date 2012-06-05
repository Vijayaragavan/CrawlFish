class AddForeignKeysToLinkProductsListsVendors < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors
        ADD CONSTRAINT fk_link_products_lists_vendors_v
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors 
	ADD CONSTRAINT fk_link_products_lists_vendors_b
        FOREIGN KEY (products_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors 
	ADD CONSTRAINT fk_link_products_lists_vendors_m
        FOREIGN KEY (products_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors
        ADD CONSTRAINT fk_link_products_lists_vendors_sc
        FOREIGN KEY (sub_category_id)
        REFERENCES subcategories(sub_category_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors
        ADD CONSTRAINT fk_link_products_lists_vendors_ba
        FOREIGN KEY (availability_id)
        REFERENCES books_vendor_f10_availabilities(availability_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_products_lists_vendors
        ADD CONSTRAINT fk_link_products_lists_vendors_ma
        FOREIGN KEY (availability_id)
        REFERENCES mobiles_vendor_f16_availabilities(availability_id)
    SQL
        
  end

  def down

    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_v"
    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_b"
    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_m"
    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_sc"
    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_ba"
    execute "ALTER TABLE link_products_lists_vendors DROP FOREIGN KEY fk_link_products_lists_vendors_ma"

  end
end

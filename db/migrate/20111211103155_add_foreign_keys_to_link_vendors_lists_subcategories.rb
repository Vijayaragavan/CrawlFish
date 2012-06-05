class AddForeignKeysToLinkVendorsListsSubcategories < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE link_vendors_lists_sub_categories
        ADD CONSTRAINT fk_link_vendors_lists_subcategories_vendors_lists
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_vendors_lists_sub_categories
        ADD CONSTRAINT fk_link_vendors_lists_subcategories_sub_categories
        FOREIGN KEY (sub_category_id)
        REFERENCES subcategories(sub_category_id)
    SQL

  end

  def down

    execute "ALTER TABLE link_vendors_lists_sub_categories DROP FOREIGN KEY fk_link_vendors_lists_subcategories_vendors_lists"
    execute "ALTER TABLE link_vendors_lists_sub_categories DROP FOREIGN KEY fk_link_vendors_lists_subcategories_sub_categories"

  end
end

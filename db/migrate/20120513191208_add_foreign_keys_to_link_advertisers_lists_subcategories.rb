class AddForeignKeysToLinkAdvertisersListsSubcategories < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE link_advertisers_lists_sub_categories
        ADD CONSTRAINT fk_link_advertisers_lists
        FOREIGN KEY (advertiser_id)
        REFERENCES advertisers_lists(advertiser_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_advertisers_lists_sub_categories
        ADD CONSTRAINT fk_link_advertisers_lists_sub_categories
        FOREIGN KEY (sub_category_id)
        REFERENCES subcategories(sub_category_id)
    SQL

  end

  def down
	execute"ALTER TABLE link_advertisers_lists_sub_categories DROP FOREIGN KEY fk_link_advertisers_lists"
	execute"ALTER TABLE link_advertisers_lists_sub_categories DROP FOREIGN KEY fk_link_advertisers_lists_sub_categories"
  end
end


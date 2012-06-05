class AddForeignKeysToLinkVendorsListsCities < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE link_vendors_lists_cities
        ADD CONSTRAINT fk_link_vendors_lists_cities_1
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_vendors_lists_cities
        ADD CONSTRAINT fk_link_vendors_lists_cities_2
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
    SQL

  end

  def down

    execute "ALTER TABLE link_vendors_lists_cities DROP FOREIGN KEY fk_link_vendors_lists_cities_1"
    execute "ALTER TABLE link_vendors_lists_cities DROP FOREIGN KEY fk_link_vendors_lists_cities_2"

  end
end

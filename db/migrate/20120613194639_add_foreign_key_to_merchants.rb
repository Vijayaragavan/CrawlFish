class AddForeignKeyToMerchants < ActiveRecord::Migration

 def up

    execute <<-SQL
      ALTER TABLE merchants 
        ADD CONSTRAINT fk_merchants_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL
 end

  def down
    execute "ALTER TABLE merchants DROP FOREIGN KEY fk_merchants_vendors"
  end

end

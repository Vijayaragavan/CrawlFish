class AddForeignKeyToOnlineMerchantProducts < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE online_merchant_products
        ADD CONSTRAINT fk_online_merchant_products_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL
 end

  def down
    execute "ALTER TABLE online_merchant_products DROP FOREIGN KEY fk_online_merchant_products_vendors"
  end
end


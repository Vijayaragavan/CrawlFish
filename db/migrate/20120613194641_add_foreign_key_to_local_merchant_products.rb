class AddForeignKeyToLocalMerchantProducts < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE local_merchant_products
        ADD CONSTRAINT fk_local_merchant_products_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL
 end

  def down
    execute "ALTER TABLE local_merchant_products DROP FOREIGN KEY fk_local_merchant_products_vendors"
  end
end


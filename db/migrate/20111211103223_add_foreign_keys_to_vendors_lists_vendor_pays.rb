class AddForeignKeysToVendorsListsVendorPays < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE fixed_pay_vendors
        ADD CONSTRAINT fk_vendors_lists_fixed_pay_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE variable_pay_vendors
        ADD CONSTRAINT fk_vendors_lists_variable_pay_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE product_purchase_commission_vendors
        ADD CONSTRAINT fk_vendors_lists_product_purchase_commission_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL


  end

  def down

    execute "ALTER TABLE fixed_pay_vendors DROP FOREIGN KEY fk_vendors_lists_fixed_pay_vendors"
    execute "ALTER TABLE variable_pay_vendors DROP FOREIGN KEY fk_vendors_lists_variable_pay_vendors"
    execute "ALTER TABLE product_purchase_commission_vendors DROP FOREIGN KEY fk_vendors_lists_product_purchase_commission_vendors"

  end
end

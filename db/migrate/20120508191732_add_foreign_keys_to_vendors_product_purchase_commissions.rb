class AddForeignKeysToVendorsProductPurchaseCommissions < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE monetization.vendors_product_purchase_commissions
        ADD CONSTRAINT fk_vendors_product_purchase_commissions_impression_rates
        FOREIGN KEY (commission_id)
        REFERENCES monetization.product_purchase_commissions(pp_commission_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_product_purchase_commissions
        ADD CONSTRAINT fk_vendors_product_purchase_commissions_cut_off_periods
        FOREIGN KEY (cut_off_period_id)
        REFERENCES monetization.cut_off_periods(cut_off_period_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_product_purchase_commissions
        ADD CONSTRAINT fk_vendors_product_purchase_commissions_cut_off_amounts
        FOREIGN KEY (cut_off_amount_id)
        REFERENCES monetization.cut_off_amounts(cut_off_amount_id)
    SQL

  end

  def down
    execute "ALTER TABLE monetization.vendors_product_purchase_commissions DROP FOREIGN KEY fk_vendors_product_purchase_commissions_impression_rates"
    execute "ALTER TABLE monetization.vendors_product_purchase_commissions DROP FOREIGN KEY fk_vendors_product_purchase_commissions_cut_off_periods"
    execute "ALTER TABLE monetization.vendors_product_purchase_commissions DROP FOREIGN KEY fk_vendors_product_purchase_commissions_cut_off_amounts"
  end
end

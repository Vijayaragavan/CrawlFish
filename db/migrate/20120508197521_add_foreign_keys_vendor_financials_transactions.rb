class AddForeignKeysVendorFinancialsTransactions < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE monetization.vendor_transactions
        ADD CONSTRAINT fk_vendors_financials_vendor_transactions
        FOREIGN KEY (vendor_financial_id)
        REFERENCES monetization.vendor_financials(vendor_financial_id)
    SQL

  end

  def down
    execute "ALTER TABLE monetization.vendor_transactions DROP FOREIGN KEY fk_vendors_financials_vendor_transactions"
  end
end

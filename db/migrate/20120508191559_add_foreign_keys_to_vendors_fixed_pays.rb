class AddForeignKeysToVendorsFixedPays < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE monetization.vendors_fixed_pays
        ADD CONSTRAINT fk_vendors_fixed_pays_fixed_pays
        FOREIGN KEY (fixed_pay_id)
        REFERENCES monetization.fixed_pays(fixed_pay_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_fixed_pays
        ADD CONSTRAINT fk_vendors_fixed_pays_cut_off_periods
        FOREIGN KEY (cut_off_period_id)
        REFERENCES monetization.cut_off_periods(cut_off_period_id)
    SQL

  end

  def down
    execute "ALTER TABLE monetization.vendors_fixed_pays DROP FOREIGN KEY fk_vendors_fixed_pays_fixed_pays"
    execute "ALTER TABLE monetization.vendors_fixed_pays DROP FOREIGN KEY fk_vendors_fixed_pays_cut_off_periods"
  end
end

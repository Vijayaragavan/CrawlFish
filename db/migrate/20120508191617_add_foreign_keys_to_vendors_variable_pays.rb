class AddForeignKeysToVendorsVariablePays < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE monetization.vendors_variable_pays
        ADD CONSTRAINT fk_vendors_variable_pays_impression_rates
        FOREIGN KEY (i_rate_id)
        REFERENCES monetization.impression_rates(i_rate_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_variable_pays
        ADD CONSTRAINT fk_vendors_variable_pays_button_click_rates
        FOREIGN KEY (bc_rate_id)
        REFERENCES monetization.button_click_rates(bc_rate_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_variable_pays
        ADD CONSTRAINT fk_vendors_variable_pays_cut_off_periods
        FOREIGN KEY (cut_off_period_id)
        REFERENCES monetization.cut_off_periods(cut_off_period_id)
    SQL

    execute <<-SQL
      ALTER TABLE monetization.vendors_variable_pays
        ADD CONSTRAINT fk_vendors_variable_pays_cut_off_amounts
        FOREIGN KEY (cut_off_amount_id)
        REFERENCES monetization.cut_off_amounts(cut_off_amount_id)
    SQL

  end

  def down
    execute "ALTER TABLE monetization.vendors_variable_pays DROP FOREIGN KEY fk_vendors_variable_pays_impression_rates"
    execute "ALTER TABLE monetization.vendors_variable_pays DROP FOREIGN KEY fk_vendors_variable_pays_button_click_rates"
    execute "ALTER TABLE monetization.vendors_variable_pays DROP FOREIGN KEY fk_vendors_variable_pays_cut_off_periods"
    execute "ALTER TABLE monetization.vendors_variable_pays DROP FOREIGN KEY fk_vendors_variable_pays_cut_off_amounts"
  end
end

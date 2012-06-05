class CreateVendorsFixedPays < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.vendors_fixed_pays"

    execute <<-SQL
    CREATE TABLE monetization.vendors_fixed_pays (
    v_fp_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    fixed_pay_id INT UNSIGNED NOT NULL,
    cut_off_period_id INT UNSIGNED NOT NULL,
    subscribed_date DATE NOT NULL,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (v_fp_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.vendors_fixed_pays"
  end
end

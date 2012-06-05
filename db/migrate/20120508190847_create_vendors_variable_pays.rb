class CreateVendorsVariablePays < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.vendors_variable_pays"

    execute <<-SQL
    CREATE TABLE monetization.vendors_variable_pays (
    v_vp_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    i_rate_id INT UNSIGNED NOT NULL,
    bc_rate_id INT UNSIGNED NOT NULL,
    cut_off_period_id INT UNSIGNED NOT NULL,
    cut_off_amount_id INT UNSIGNED NOT NULL,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (v_vp_id),
    UNIQUE (vendor_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.vendors_variable_pays"
  end
end

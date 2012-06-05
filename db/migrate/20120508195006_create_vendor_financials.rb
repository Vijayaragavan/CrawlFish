class CreateVendorFinancials < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.vendor_financials"

    execute <<-SQL
    CREATE TABLE monetization.vendor_financials (
    vendor_financial_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    monetization_id INT UNSIGNED NOT NULL,
    monetization_type VARCHAR(255) NOT NULL,
    subscription_date DATE NOT NULL,
    notification_date DATE NOT NULL,
    cut_off_date DATE NOT NULL,
    amount DOUBLE NOT NULL,
    paid_flag INT UNSIGNED DEFAULT 0,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (vendor_financial_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.vendor_financials"
  end
end

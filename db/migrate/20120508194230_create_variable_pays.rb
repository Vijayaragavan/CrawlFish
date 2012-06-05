class CreateVariablePays < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.variable_pays"

    execute <<-SQL
    CREATE TABLE monetization.variable_pays (
    variable_pay_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    total_amount DOUBLE NOT NULL,
    paid_flag INT UNSIGNED DEFAULT 0,
    history_flag INT UNSIGNED DEFAULT 0,
    financial_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (variable_pay_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.variable_pays"
  end
end

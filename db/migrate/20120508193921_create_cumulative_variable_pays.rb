class CreateCumulativeVariablePays < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.cumulative_variable_pays"

    execute <<-SQL
    CREATE TABLE monetization.cumulative_variable_pays (
    c_vp_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    sub_category_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    total_amount DOUBLE NOT NULL,
    log_date DATE NOT NULL,
    history_flag INT UNSIGNED DEFAULT 0,
    variable_pay_id INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (c_vp_id),
    UNIQUE (vendor_id,sub_category_id,product_id,log_date)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.cumulative_variable_pays"
  end
end

class CreateVariblePayLogs < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.variable_pay_logs"

    execute <<-SQL
    CREATE TABLE monetization.variable_pay_logs (
    vp_log_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    sub_category_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    total_impressions_amount DOUBLE NOT NULL,
    total_button_clicks_amount DOUBLE NOT NULL,
    log_date DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (vp_log_id),
    UNIQUE (vendor_id,sub_category_id,product_id,log_date)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.variable_pay_logs"
  end
end

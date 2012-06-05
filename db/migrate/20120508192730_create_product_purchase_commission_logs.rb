class CreateProductPurchaseCommissionLogs < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.product_purchase_commission_logs"

    execute <<-SQL
    CREATE TABLE monetization.product_purchase_commission_logs (
    pp_comm_log_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    sub_category_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    total_pp_comm_amount DOUBLE NOT NULL,
    log_date DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (pp_comm_log_id),
    UNIQUE (vendor_id,sub_category_id,product_id,log_date)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.product_purchase_commission_logs"
  end
end

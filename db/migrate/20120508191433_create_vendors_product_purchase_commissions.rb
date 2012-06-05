class CreateVendorsProductPurchaseCommissions < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.vendors_product_purchase_commissions"

    execute <<-SQL
    CREATE TABLE monetization.vendors_product_purchase_commissions (
    v_pp_comm_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    sub_category_id INT UNSIGNED NOT NULL,
    commission_id INT UNSIGNED NOT NULL,
    cut_off_period_id INT UNSIGNED NOT NULL,
    cut_off_amount_id INT UNSIGNED NOT NULL,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (v_pp_comm_id),
    UNIQUE (vendor_id,sub_category_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.vendors_product_purchase_commissions"
  end
end

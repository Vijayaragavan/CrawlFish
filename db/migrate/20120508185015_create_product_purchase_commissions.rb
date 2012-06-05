class CreateProductPurchaseCommissions < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.product_purchase_commissions"

    execute <<-SQL
    CREATE TABLE monetization.product_purchase_commissions (
    pp_commission_id INT UNSIGNED AUTO_INCREMENT,
    product_purchase_commissions DOUBLE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (pp_commission_id),
    UNIQUE (product_purchase_commissions)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.product_purchase_commissions"
  end
end

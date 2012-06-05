class CreateFixedPays < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.fixed_pays"

    execute <<-SQL
    CREATE TABLE monetization.fixed_pays (
    fixed_pay_id INT UNSIGNED AUTO_INCREMENT,
    subscription_cost DOUBLE NOT NULL,
    subscription_period INT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (fixed_pay_id),
    UNIQUE (subscription_cost,subscription_period)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.fixed_pays"
  end
end

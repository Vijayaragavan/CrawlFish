class CreateImpressionRates < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.impression_rates"

    execute <<-SQL
    CREATE TABLE monetization.impression_rates (
    i_rate_id INT UNSIGNED AUTO_INCREMENT,
    impression_rates DOUBLE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (i_rate_id),
    UNIQUE (impression_rates)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.impression_rates"
  end
end

class CreateButtonClickRates < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.button_click_rates"

    execute <<-SQL
    CREATE TABLE monetization.button_click_rates (
    bc_rate_id INT UNSIGNED AUTO_INCREMENT,
    button_click_rates DOUBLE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (bc_rate_id),
    UNIQUE (button_click_rates)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.button_click_rates"
  end
end

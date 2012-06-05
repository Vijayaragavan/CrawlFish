class CreateCutOffPeriods < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.cut_off_periods"

    execute <<-SQL
    CREATE TABLE monetization.cut_off_periods (
    cut_off_period_id INT UNSIGNED AUTO_INCREMENT,
    cut_off_period INT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (cut_off_period_id),
    UNIQUE (cut_off_period)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.cut_off_periods"
  end
end

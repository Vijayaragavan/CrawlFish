class CreateCutOffAmounts < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.cut_off_amounts"

    execute <<-SQL
    CREATE TABLE monetization.cut_off_amounts (
    cut_off_amount_id INT UNSIGNED AUTO_INCREMENT,
    cut_off_amount DOUBLE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (cut_off_amount_id),
    UNIQUE (cut_off_amount)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.cut_off_amounts"
  end
end

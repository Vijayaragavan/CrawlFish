class CreateTempTransactionsLogs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS temp_transactions_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_transactions_logs (
  log_id INT UNSIGNED AUTO_INCREMENT,
  unique_id INT UNSIGNED NOT NULL,
  type VARCHAR(255) NOT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE temp_transactions_logs"
  end
end

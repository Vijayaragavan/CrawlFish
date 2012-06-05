class CreateMobilesF11Processors < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f11_processors"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f11_processors (
  processor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  processor VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (processor_id),
  UNIQUE(processor)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f11_processors"
  end
end

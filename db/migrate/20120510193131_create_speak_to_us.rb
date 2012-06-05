class CreateSpeakToUs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS speak_to_us"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS speak_to_us (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  contact_number VARCHAR(255) NOT NULL,
  message TEXT,
  advertisement_flag CHAR(1) DEFAULT "n",
  query_flag CHAR(1) DEFAULT "n",
  suggestion_flag CHAR(1) DEFAULT "n",
  defect_flag CHAR(1) DEFAULT "n",
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE speak_to_us"
  end
end

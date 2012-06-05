class CreateStopwords < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS stopwords"	   

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS stopwords (
  stopword_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  stopword VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (stopword_id),
  UNIQUE (stopword)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

  end

  def down
	execute "DROP TABLE stopwords"
  end
end

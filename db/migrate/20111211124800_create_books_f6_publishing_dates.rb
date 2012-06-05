class CreateBooksF6PublishingDates < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_f6_publishing_dates"
  execute <<-SQL
  
  CREATE TABLE IF NOT EXISTS books_f6_publishing_dates (
  publishing_date_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  publishing_date INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (publishing_date_id),
  UNIQUE (publishing_date)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_f6_publishing_dates"
  end
end


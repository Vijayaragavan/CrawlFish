class CreateBooksVendorF10Availabilities < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS books_vendor_f10_availabilities"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS books_vendor_f10_availabilities (
  availability_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  availability VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (availability_id),
  UNIQUE (availability)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE books_vendor_f10_availabilities"
  end
end

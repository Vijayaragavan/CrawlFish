class CreateAdvertisersLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS advertisers_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS advertisers_lists (
  advertiser_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  advertiser_name VARCHAR(255) NOT NULL,
  advertiser_email VARCHAR(255) NOT NULL,
  advertiser_phone VARCHAR(255) NOT NULL,
  advertiser_fax VARCHAR(255) DEFAULT "na",
  advertiser_address TEXT NOT NULL,
  advertiser_sub_categories VARCHAR(500) NOT NULL,
  subscribed_date DATE NOT NULL,
  advertiser_rating INT UNSIGNED DEFAULT "0",
  blocked_flag INT UNSIGNED DEFAULT "0",
  discarded_flag INT UNSIGNED 	DEFAULT "0",
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (advertiser_id),
  UNIQUE (advertiser_name),
  UNIQUE (advertiser_phone)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE advertisers_lists"
  end
end


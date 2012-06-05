class CreateAdLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS ad_lists"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS ad_lists (
  ad_list_id INT UNSIGNED AUTO_INCREMENT,
  advertiser_id INT NOT NULL,
  ad_reference VARCHAR(255) NOT NULL,
  sub_category_id INT NOT NULL,
  banner_height INT NOT NULL,
  banner_width INT NOT NULL,
  duration INT NOT NULL,
  subscribed_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (ad_list_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE ad_lists"
  end
end


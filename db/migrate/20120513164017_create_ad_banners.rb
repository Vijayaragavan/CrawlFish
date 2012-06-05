class CreateAdBanners < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS ad_banners"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS ad_banners (
  banner_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  banner_height INT NOT NULL,
  banner_width INT NOT NULL,
  duration INT NOT NULL,
  banner_cost DOUBLE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (banner_id),
  UNIQUE (banner_height,banner_width,duration,banner_cost)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE ad_banners"
  end
end


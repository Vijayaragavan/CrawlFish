class CreateMobilesF1MobileBrands < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f1_mobile_brands"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f1_mobile_brands (
  mobile_brand_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobile_brand_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (mobile_brand_id),
  UNIQUE(mobile_brand_name)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f1_mobile_brands"
  end
end

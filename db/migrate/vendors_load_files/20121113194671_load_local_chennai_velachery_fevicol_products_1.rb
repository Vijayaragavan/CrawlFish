class LoadLocalChennaiVelacheryFevicolProducts1 < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '/home/karthik/Desktop/CrawlFish2012-Jun4/Offline_Saholic_mobiles.dat' INTO TABLE local_chennai_velachery_fevicol_products FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM local_chennai_velachery_fevicol_products"  

  end
end

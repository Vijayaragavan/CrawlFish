class LoadLocalChennaiTambaramSharkseapeopleProducts3 < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '/home/vijayaragavanv/rubyonrails/CrawlFish2012apr13/2012apr12/Offline_StackYourRack_books.dat' INTO TABLE local_chennai_tambaram_sharkseapeople_products FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM local_chennai_tambaram_sharkseapeople_products"  

  end
end

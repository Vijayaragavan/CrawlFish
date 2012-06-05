class LoadOnlineFlipkartProducts2 < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '/home/vijayaragavanv/rubyonrails/CrawlFish2012apr13/2012apr12/Online_Flipkart_Books.dat' INTO TABLE online_flipkart_products FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM online_flipkart_products"  

  end
end

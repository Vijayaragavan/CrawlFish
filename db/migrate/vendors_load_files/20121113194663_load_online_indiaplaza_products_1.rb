class LoadOnlineIndiaplazaProducts1 < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '/home/karthik/Desktop/CrawlFish2012-Jun4/Online_Crossword_books.dat' INTO TABLE online_indiaplaza_products FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM online_indiaplaza_products"  

  end
end

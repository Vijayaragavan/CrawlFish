class LoadOnlineFlipkartProducts7 < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '/home/vijayaragavanv/rubyonrails/load/part1/Online_Flipkart_books_Award_Winning_p1.dat' INTO TABLE online_flipkart_products FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM online_flipkart_products"  

  end
end

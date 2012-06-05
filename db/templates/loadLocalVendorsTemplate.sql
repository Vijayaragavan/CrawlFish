class Load<<class_vendor_type>><<class_city_name>><<class_branch_name>><<class_vendor_name>>Products<<count>> < ActiveRecord::Migration

  def up

    execute <<-SQL
   
      LOAD DATA LOCAL INFILE '<<data_file_path>>' INTO TABLE <<table_name>> FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL

  end
  

  def down

   execute "DELETE FROM <<table_name>>"  

  end
end

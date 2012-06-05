class CreateFiltersCollections < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS filters_collections"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS filters_collections (
  filters_collection_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  filter_key VARCHAR(255) NOT NULL,
  filter_id INT UNSIGNED NOT NULL,
  filter_table_name VARCHAR(255) NOT NULL,
  filter_table_column VARCHAR(255) NOT NULL, 
  sub_category_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (filters_collection_id),
  UNIQUE (filter_key,filter_id,filter_table_name,filter_table_column)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE filters_collections"
  end
end


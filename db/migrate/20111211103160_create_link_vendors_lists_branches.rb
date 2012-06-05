class CreateLinkVendorsListsBranches < ActiveRecord::Migration
  def up
  execute "DROP TABLE IF EXISTS link_vendors_lists_branches"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_vendors_lists_branches (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  branch_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (vendor_id,branch_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE link_vendors_lists_branches"
  end
end

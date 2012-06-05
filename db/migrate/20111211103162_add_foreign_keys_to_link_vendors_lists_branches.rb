class AddForeignKeysToLinkVendorsListsBranches < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE link_vendors_lists_branches
        ADD CONSTRAINT fk_link_vendors_lists_branches_1
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_vendors_lists_branches
        ADD CONSTRAINT fk_link_vendors_lists_branches_2
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
    SQL

  end

  def down

    execute "ALTER TABLE link_vendors_lists_branches DROP FOREIGN KEY fk_link_vendors_lists_branches_1"
    execute "ALTER TABLE link_vendors_lists_branches DROP FOREIGN KEY fk_link_vendors_lists_branches_2"


  end
end

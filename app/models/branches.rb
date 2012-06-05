class Branches < ActiveRecord::Base

  belongs_to :cities, :class_name => "Cities", :foreign_key => "city_id"

  def self.get_vendor_id_branch_name(vendor_name,product_id,sub_category_id)

    joins("INNER JOIN link_vendors_lists_branches ON branches.branch_id = link_vendors_lists_branches.branch_id INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.vendor_id = link_vendors_lists_branches.vendor_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id AND vendors_lists.vendor_id = link_vendors_lists_branches.vendor_id").where("f_stripstring(vendors_lists.vendor_name) = ? AND link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?",vendor_name.downcase.squeeze(" ").gsub(/ /,"").gsub(/,.-/,""),product_id,sub_category_id).select("vendors_lists.vendor_id,branches.branch_name")

  end

  def self.get_current_branch(vendor_id)

    joins("INNER JOIN link_vendors_lists_branches
          ON branches.branch_id = link_vendors_lists_branches.branch_id
          INNER JOIN vendors_lists
          ON vendors_lists.vendor_id = link_vendors_lists_branches.vendor_id ").where("vendors_lists.vendor_id = ?",vendor_id).select("vendors_lists.vendor_id,branches.branch_name").map{|i| [i.branch_name,i.vendor_id]}[0]

  end

end


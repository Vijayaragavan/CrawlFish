class LinkVendorsListsBranches < ActiveRecord::Base

  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "vendor_id",
  :conditions => ['link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?', 2 , 3]
  has_many :grids, :through => :vendorlinks, :class_name => "LocalGridDetails", :foreign_key => "unique_id"



end


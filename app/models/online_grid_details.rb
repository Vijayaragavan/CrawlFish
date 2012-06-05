class OnlineGridDetails < ActiveRecord::Base


  #has_many :bookslinks , :class_name => "LinkBooksListsVendors", :foreign_key => "unique_id"
  #has_many :grids, :through => :bookslinks , :class_name => "BooksLists", :foreign_key => "books_list_id"
  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "unique_id"
  has_many :vendor_logo, :through => :vendorlinks, :class_name => "VendorsList", :foreign_key => "vendor_id",:select => "vendor_logo"

  def self.get_available_from_online(product_id,sub_category_id)
	
	if(sub_category_id==1)

		availability_id = BooksVendorF10Availabilities.get_availability_ids(["out of stock","out of print","permanently discontinued","comming soon"])

	joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = online_grid_details.unique_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id not in (?)",product_id,sub_category_id,availability_id).select("price").minimum("price")
	
	elsif(sub_category_id==2)
		
		availability_id = MobilesVendorF16Availabilities.get_availability_ids(["out of stock"])

	joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = online_grid_details.unique_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id not in (?)",product_id,sub_category_id,availability_id).select("price").minimum("price")
	end
  end

  def self.get_grid(product_id,sub_category_id, excludable_availability_ids = 0)

    if (excludable_availability_ids == 0)

      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = online_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?",product_id,sub_category_id).select("online_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.miscellaneous").order("online_grid_details.price ASC")


     elsif !(excludable_availability_ids == 0)

      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = online_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id NOT IN (?)",product_id,sub_category_id,excludable_availability_ids).select("online_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.miscellaneous").order("online_grid_details.price ASC")


     end

  end



end


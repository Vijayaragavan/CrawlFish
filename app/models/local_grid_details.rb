class LocalGridDetails < ActiveRecord::Base


  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "unique_id"
  has_many :vendors, :through => :vendorlinks, :class_name => "VendorsList", :foreign_key => "vendor_id"

  #def self.get_grid(unique_ids)

    #where("unique_id IN (?)",unique_ids)

  #end
  def self.get_available_from_local(product_id,sub_category_id)
	
	if(sub_category_id==1)

		availability_id = BooksVendorF10Availabilities.get_availability_ids(["out of stock","out of print","permanently discontinued","comming soon"])

	joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id not in (?)",product_id,sub_category_id,availability_id).select("price").minimum("price")
	
	elsif(sub_category_id==2)

		availability_id = MobilesVendorF16Availabilities.get_availability_ids(["out of stock"])

	joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id not in (?)",product_id,sub_category_id,availability_id).select("price").minimum("price")
	end
	
 	
  end

  def self.get_grid(product_id,sub_category_id, excludable_availability_ids = 0,area_id = 0)

    if (area_id == 0 && excludable_availability_ids == 0)

      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id INNER JOIN link_vendors_lists_branches ON link_vendors_lists_branches.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?",product_id,sub_category_id).select("local_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.branch_name,vendors_lists.miscellaneous").order("local_grid_details.price ASC")

    elsif (!(area_id == 0) && (excludable_availability_ids == 0))


      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id INNER JOIN link_vendors_lists_branches ON link_vendors_lists_branches.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_vendors_lists_branches.branch_id = ?",product_id,sub_category_id,area_id).select("local_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.branch_name,vendors_lists.miscellaneous").order("local_grid_details.price ASC")

     elsif ((area_id == 0) && !(excludable_availability_ids == 0))

      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id INNER JOIN link_vendors_lists_branches ON link_vendors_lists_branches.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id NOT IN (?)",product_id,sub_category_id,excludable_availability_ids).select("local_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.branch_name,vendors_lists.miscellaneous").order("local_grid_details.price ASC")

      elsif (!(area_id == 0) && !(excludable_availability_ids == 0))

      joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id INNER JOIN link_vendors_lists_branches ON link_vendors_lists_branches.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND link_products_lists_vendors.availability_id NOT IN (?) AND link_vendors_lists_branches.branch_id = ?",product_id,sub_category_id,excludable_availability_ids,area_id).select("local_grid_details.*,vendors_lists.vendor_id,vendors_lists.vendor_name,vendors_lists.vendor_logo,vendors_lists.branch_name,vendors_lists.miscellaneous").order("local_grid_details.price ASC")

     end

  end




end


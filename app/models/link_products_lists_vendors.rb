class LinkProductsListsVendors < ActiveRecord::Base

  #belongs_to :books, :class_name => "BooksList", :foreign_key => ["products_list_id","sub_category_id"]
  #belongs_to :mobiles, :class_name => "MobilesList", :foreign_key => "products_list_id"

  belongs_to :vendors, :class_name => "VendorsList", :foreign_key => "vendor_id"
  belongs_to :vendor_logo, :class_name => "VendorsList", :foreign_key => "vendor_id"

  belongs_to :availabilities , :class_name => "books_v_f10_availabilities", :foreign_key => "availability_id"
  belongs_to :online_grids, :class_name => "OnlineGridDetails", :foreign_key => "unique_id"
  belongs_to :local_grids, :class_name => "LocalGridDetails", :foreign_key => "unique_id"

  belongs_to :grids, :class_name => "LocalGridDetails", :foreign_key => "unique_id"
  belongs_to :branches, :class_name => "LinkVendorsListsBranches", :foreign_key => "vendor_id"
  belongs_to :vendorlinks, :class_name => "LinkVendorsListsBranches", :foreign_key => "vendor_id"

   def self.get_products_list_id(sub_category_id)

    where("sub_category_id = ?",sub_category_id).select("distinct(products_list_id)").map &:products_list_id

  end

  def self.get_unique_id(products_list_id,sub_category_id,availability_ids = 0)

    if availability_ids == 0

      where("products_list_id = ? AND sub_category_id = ?",products_list_id,sub_category_id).select("unique_id").map &:unique_id

    else

      where("products_list_id = ? AND sub_category_id = ? AND availability_id NOT IN (?) ",products_list_id,sub_category_id,availability_ids).select("unique_id").map &:unique_id

    end

  end

  def self.get_products_list_id_from_unique_id(unique_id)

    where(:unique_id  => unique_id).select("products_list_id").first

  end

  def self.get_products_list_id_sub_category_id_from_unique_id(unique_id,sub_category_id = 0)

    if sub_category_id == 0

      where(:unique_id  => unique_id).select("DISTINCT(products_list_id) AS products_list_id,sub_category_id")

    else

      where(:unique_id  => unique_id,:sub_category_id => sub_category_id).select("DISTINCT(products_list_id) AS products_list_id,sub_category_id")

    end

  end




end


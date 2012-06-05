class MobilesLists < ActiveRecord::Base

   has_many :vendorlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :vendors, :through => :vendorlinks , :class_name => "VendorsList", :foreign_key => "vendor_id"

   has_many :onlinegridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :online_grids, :through => :onlinegridlinks , :class_name => "OnlineGridDetails", :foreign_key => "unique_id"

   has_many :localgridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :local_grids, :through => :localgridlinks , :class_name => "LocalGridDetails", :foreign_key => "unique_id"
   #senthil - 2012mar02 add availability to books and vendors
   has_many :availabilitylinks , :class_name => "LinkProductsListsVendors", :foreign_key => "availability_id"
   has_many :availabilities, :through => :availabilitylinks , :class_name => "VendorsList", :foreign_key => "vendor_id"


   def self.fetch_exact_match(product_id)

    where("mobiles_list_id= ?",product_id)

   end

   def self.get_mobile_name(mobiles_list_id)

     where("mobiles_list_id= ?",mobiles_list_id).map &:mobile_name

   end

   def self.get_colors(mobile_name)

     where("f_stripstring(mobile_name) = f_stripstring(?)",mobile_name).select("mobiles_list_id,mobile_color").map{|i| [i.mobile_color.titlecase,i.mobiles_list_id]}

   end


end


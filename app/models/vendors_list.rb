class VendorsList < ActiveRecord::Base

  #has_many :bookslinks , :class_name => "LinkBooksListsVendors", :foreign_key => "vendor_id"
  #has_many :books, :through => :bookslinks , :class_name => "BooksLists", :foreign_key => "books_list_id"

 # has_many :gridslinks, :class_name => "LinkBooksListsVendors", :foreign_key => "vendor_id"
#  has_many :grids, :through => :gridslinks, :class_name => "OnlineGridDetails", :foreign_key => "

  has_many :sub_category_links , :class_name => "LinkVendorsListsSubCategories", :foreign_key => "vendor_id"
  has_many :sub_categories, :through => :sub_category_links , :class_name => "Subcategories", :foreign_key => "sub_category_id"

  def self.get_latitude_longitude(vendor_name,branch_name)

    where(:vendor_name => vendor_name,:branch_name => branch_name).select("latitude,longitude").map{|i| [i.latitude,i.longitude]}.flatten.join(",")

  end

end


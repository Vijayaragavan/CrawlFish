class LinkVendorsListsSubCategories < ActiveRecord::Base

    belongs_to :vendors, :class_name => "VendorsList", :foreign_key => "vendor_id"
    belongs_to :sub_categories, :class_name => "Subcategories", :foreign_key => "sub_category_id"



end


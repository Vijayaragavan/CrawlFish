class BooksF10Availability < ActiveRecord::Base

     has_many :availabilitylinks , :class_name => "LinkF10BooksLists", :foreign_key => "availability_id"
     has_many :books, :through => :availabilitylinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


class BooksF5Binding < ActiveRecord::Base

     has_many :bindinglinks , :class_name => "LinkF5BooksLists", :foreign_key => "binding_id"
     has_many :books, :through => :bindinglinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

     def self.get_binding_names(binding_id)

       where("binding_id IN (?)", binding_id ).select("binding_name").map {|v| v.binding_name}

     end

end


class BooksF1Author < ActiveRecord::Base
     has_many :authorlinks , :class_name => "LinkF1BooksLists", :foreign_key => "author_id"
     has_many :books, :through => :authorlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"
end


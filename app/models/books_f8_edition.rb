class BooksF8Edition < ActiveRecord::Base

     has_many :editionlinks , :class_name => "LinkF8BooksLists", :foreign_key => "edition_id"
     has_many :books, :through => :editionlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


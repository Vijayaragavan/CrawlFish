class BooksF4Isbn13 < ActiveRecord::Base

     has_many :isbn13links , :class_name => "LinkF4BooksLists", :foreign_key => "isbn13_id"
     has_many :books, :through => :isbn13links, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


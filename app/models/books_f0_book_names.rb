class BooksF0BookNames < ActiveRecord::Base

   has_many :booklinks , :class_name => "LinkF0BooksLists", :foreign_key => "book_name_id"
     has_many :books, :through => :booklinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


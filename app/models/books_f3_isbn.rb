class BooksF3Isbn < ActiveRecord::Base

    has_many :isbnlinks , :class_name => "LinkF3BooksLists", :foreign_key => "isbn_id"
    has_many :books, :through => :isbnlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

    has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
    has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


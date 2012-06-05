class LinkF3BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :isbns, :class_name => "BooksF3Isbn", :foreign_key => "isbn_id"

end


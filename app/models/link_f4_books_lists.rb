class LinkF4BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :isbn13s, :class_name => "BooksF4Isbn13", :foreign_key => "isbn13_id"

end


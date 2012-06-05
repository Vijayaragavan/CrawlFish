class LinkF8BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :editions, :class_name => "BooksF8Edition", :foreign_key => "edition_id"

end


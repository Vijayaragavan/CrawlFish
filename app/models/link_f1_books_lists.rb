class LinkF1BooksLists < ActiveRecord::Base
  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :authors, :class_name => "BooksF1Author", :foreign_key => "author_id"
end


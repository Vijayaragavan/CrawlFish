class LinkF9BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :languages, :class_name => "BooksF9Language", :foreign_key => "language_id"

end


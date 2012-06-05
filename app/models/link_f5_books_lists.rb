class LinkF5BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :bindings, :class_name => "BooksF5Binding", :foreign_key => "binding_id"

end


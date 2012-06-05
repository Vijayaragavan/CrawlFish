class LinkF7BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :publishers, :class_name => "BooksF7Publisher", :foreign_key => "publisher_id"

end


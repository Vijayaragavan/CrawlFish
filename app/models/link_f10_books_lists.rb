class LinkF10BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :availabilities, :class_name => "BooksF10Availability", :foreign_key => "availability_id"

end


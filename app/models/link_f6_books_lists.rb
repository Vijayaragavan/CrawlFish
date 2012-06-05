class LinkF6BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :publishingdates, :class_name => "BooksF6PublishingDate", :foreign_key => "publishing_date_id"

end


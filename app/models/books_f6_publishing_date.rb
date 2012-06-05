class BooksF6PublishingDate < ActiveRecord::Base

    has_many :publishingdatelinks , :class_name => "LinkF6BooksLists", :foreign_key => "publishing_date_id"
    has_many :books, :through => :publishingdatelinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

    has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
    has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

end


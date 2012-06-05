class BooksF7Publisher < ActiveRecord::Base

     has_many :publisherlinks , :class_name => "LinkF7BooksLists", :foreign_key => "publisher_id"
     has_many :books, :through => :publisherlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

     def self.get_publishers(publisher_id)

       where("publisher_id IN (?)", publisher_id ).select("publisher").map {|v| v.publisher}

     end

end


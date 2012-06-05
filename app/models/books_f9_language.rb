class BooksF9Language < ActiveRecord::Base

     has_many :languagelinks , :class_name => "LinkF9BooksLists", :foreign_key => "language_id"
     has_many :books, :through => :languagelinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

     def self.get_languages(language_id)

       where("language_id IN (?)", language_id ).select("language_name").map {|v| v.language_name}

     end


end


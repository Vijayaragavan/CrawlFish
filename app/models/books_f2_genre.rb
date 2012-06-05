class BooksF2Genre < ActiveRecord::Base
  has_many :genrelinks , :class_name => "LinkF2BooksLists", :foreign_key => "genre_id"
  has_many :books, :through => :genrelinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

  has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
  has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

  def self.get_genre_names(genre_id)

    where("genre_id IN (?)", genre_id ).select("genre_name").map {|v| v.genre_name}

  end

end


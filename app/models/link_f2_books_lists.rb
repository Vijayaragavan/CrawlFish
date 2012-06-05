class LinkF2BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :genres, :class_name => "BooksF2Genre", :foreign_key => "genre_id"

  def self.get_genre_ids(books_list_id)

    where("books_list_id IN (?)",books_list_id.map {|x| x} ).select("distinct genre_id").map &:genre_id

  end

  def self.get_similar_books_list_id(product_id,sub_category_id)

    joins("INNER JOIN link_f2_books_lists AS bl2
            ON link_f2_books_lists.genre_id = bl2.genre_id
            INNER JOIN books_f2_genres AS g2
            ON bl2.genre_id = g2.genre_id
            INNER JOIN link_products_lists_vendors
            ON link_products_lists_vendors.products_list_id =
            link_f2_books_lists.books_list_id").where("bl2.books_list_id = ?
            AND g2.level_id = 1
            AND link_products_lists_vendors.sub_category_id = ?
            AND products_list_id != ?",product_id,
            sub_category_id,product_id).select("DISTINCT(link_f2_books_lists.books_list_id)
            AS products_list_id").order("RAND()").limit(1).map &:products_list_id


  end



end


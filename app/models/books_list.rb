
class BooksList < ActiveRecord::Base


   has_many :authorlinks , :class_name => "LinkF1BooksLists", :foreign_key => "books_list_id"
   has_many :authors, :through => :authorlinks , :class_name => "BooksF1Author", :foreign_key => "author_id"

   has_many :genrelinks , :class_name => "LinkF2BooksLists", :foreign_key => "books_list_id"
   has_many :genres, :through => :genrelinks , :class_name => "BooksF2Genre", :foreign_key => "genre_id"

   has_many :isbnlinks , :class_name => "LinkF3BooksLists", :foreign_key => "books_list_id"
   has_many :isbns, :through => :isbnlinks , :class_name => "BooksF3Isbn", :foreign_key => "isbn_id"

   has_many :isbn13links , :class_name => "LinkF4BooksLists", :foreign_key => "books_list_id"
   has_many :isbn13s, :through => :isbn13links , :class_name => "BooksF4Isbn13", :foreign_key => "isbn13_id"

   has_many :bindinglinks , :class_name => "LinkF5BooksLists", :foreign_key => "books_list_id"
   has_many :bindings, :through => :bindinglinks , :class_name => "BooksF5Binding", :foreign_key => "binding_id"

   has_many :publishingdatelinks , :class_name => "LinkF6BooksLists", :foreign_key => "books_list_id"
   has_many :publishingdates, :through => :publishingdatelinks , :class_name => "BooksF6PublishingDate", :foreign_key =>    "publishing_date_id"

   has_many :publisherlinks , :class_name => "LinkF7BooksLists", :foreign_key => "books_list_id"
   has_many :publishers, :through => :publisherlinks , :class_name => "BooksF7Publisher", :foreign_key => "publisher_id"

   has_many :editionlinks , :class_name => "LinkF8BooksLists", :foreign_key => "books_list_id"
   has_many :editions, :through => :editionlinks , :class_name => "BooksF8Edition", :foreign_key => "edition_id"

   has_many :languagelinks , :class_name => "LinkF9BooksLists", :foreign_key => "books_list_id"
   has_many :languages, :through => :languagelinks , :class_name => "BooksF9Language", :foreign_key => "language_id"

   has_many :availabilitylinks , :class_name => "LinkF10BooksLists", :foreign_key => "books_list_id"
   has_many :availabilities, :through => :availabilitylinks , :class_name => "BooksF10Availability", :foreign_key => "availability_id"

   has_many :vendorlinks , :class_name => "LinkBooksListsVendors", :foreign_key => "books_list_id"
   has_many :vendors, :through => :vendorlinks , :class_name => "VendorsList", :foreign_key => "vendor_id"

   has_many :onlinegridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => ["products_list_id","sub_category_id"]
   has_many :online_grids, :through => :onlinegridlinks , :class_name => "OnlineGridDetails", :foreign_key => "unique_id"

   has_many :localgridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :local_grids, :through => :localgridlinks , :class_name => "LocalGridDetails", :foreign_key => "unique_id"
   #senthil - 2012mar02 add availability to books and vendors
   has_many :availabilitylinks , :class_name => "LinkBooksListsVendors", :foreign_key => "availability_id"
   has_many :availabilities, :through => :availabilitylinks , :class_name => "VendorsList", :foreign_key => "vendor_id"


   def self.fetch_exact_match(product_id)

    where("books_list_id= ?",product_id)

   end

   def self.get_book_name(books_list_id)

     where("books_list_id= ?",books_list_id).map &:book_name

   end


 #  def self.search(searchkey)
  #  if searchkey
   #   find(:all,:select => 'books_list_id', :conditions => ['book_name LIKE (?)', "%#{searchkey}%"])
    #else
     # puts "Book not found!"
    #end
   #end





end


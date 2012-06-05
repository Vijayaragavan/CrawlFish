# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121113194639) do

  create_table "ad_banners", :primary_key => "banner_id", :force => true do |t|
    t.integer  "banner_height", :null => false
    t.integer  "banner_width",  :null => false
    t.integer  "duration",      :null => false
    t.float    "banner_cost",   :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "ad_banners", ["banner_height", "banner_width", "duration", "banner_cost"], :name => "banner_height", :unique => true

  create_table "ad_lists", :primary_key => "ad_list_id", :force => true do |t|
    t.integer  "advertiser_id",   :null => false
    t.string   "ad_reference",    :null => false
    t.integer  "sub_category_id", :null => false
    t.integer  "banner_height",   :null => false
    t.integer  "banner_width",    :null => false
    t.integer  "duration",        :null => false
    t.date     "subscribed_date", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "ad_lists", ["banner_height", "banner_width", "duration"], :name => "fk_ad_lists_ad_banners"

  create_table "advertisers_lists", :primary_key => "advertiser_id", :force => true do |t|
    t.string   "advertiser_name",                                            :null => false
    t.string   "advertiser_email",                                           :null => false
    t.string   "advertiser_phone",                                           :null => false
    t.string   "advertiser_fax",                           :default => "na"
    t.text     "advertiser_address",                                         :null => false
    t.string   "advertiser_sub_categories", :limit => 500,                   :null => false
    t.date     "subscribed_date",                                            :null => false
    t.integer  "advertiser_rating",                        :default => 0
    t.integer  "blocked_flag",                             :default => 0
    t.integer  "discarded_flag",                           :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at"
  end

  add_index "advertisers_lists", ["advertiser_name"], :name => "advertiser_name", :unique => true
  add_index "advertisers_lists", ["advertiser_phone"], :name => "advertiser_phone", :unique => true

  create_table "books_f1_authors", :primary_key => "author_id", :force => true do |t|
    t.string   "author_name", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  add_index "books_f1_authors", ["author_name"], :name => "author_name", :unique => true

  create_table "books_f2_genres", :primary_key => "genre_id", :force => true do |t|
    t.string   "genre_name", :null => false
    t.integer  "level_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f2_genres", ["genre_name", "level_id"], :name => "genre_name", :unique => true

  create_table "books_f3_isbns", :primary_key => "isbn_id", :force => true do |t|
    t.string   "isbn",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f3_isbns", ["isbn"], :name => "isbn", :unique => true

  create_table "books_f4_isbn13s", :primary_key => "isbn13_id", :force => true do |t|
    t.string   "isbn13",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f4_isbn13s", ["isbn13"], :name => "isbn13", :unique => true

  create_table "books_f5_bindings", :primary_key => "binding_id", :force => true do |t|
    t.string   "binding_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_f5_bindings", ["binding_name"], :name => "binding_name", :unique => true

  create_table "books_f6_publishing_dates", :primary_key => "publishing_date_id", :force => true do |t|
    t.integer  "publishing_date", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "books_f6_publishing_dates", ["publishing_date"], :name => "publishing_date", :unique => true

  create_table "books_f7_publishers", :primary_key => "publisher_id", :force => true do |t|
    t.string   "publisher",       :null => false
    t.string   "publisher_alias", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "books_f7_publishers", ["publisher"], :name => "publisher", :unique => true

  create_table "books_f8_editions", :primary_key => "edition_id", :force => true do |t|
    t.string   "edition_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_f8_editions", ["edition_name"], :name => "edition_name", :unique => true

  create_table "books_f9_languages", :primary_key => "language_id", :force => true do |t|
    t.string   "language_name", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "books_f9_languages", ["language_name"], :name => "language_name", :unique => true

  create_table "books_lists", :primary_key => "books_list_id", :force => true do |t|
    t.string   "book_name",      :null => false
    t.text     "book_image_url"
    t.text     "book_features",  :null => false
    t.string   "isbn",           :null => false
    t.string   "isbn13",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "books_lists", ["isbn", "isbn13"], :name => "isbn", :unique => true

  create_table "books_reviews", :force => true do |t|
    t.string   "isbn",           :null => false
    t.string   "isbn13",         :null => false
    t.text     "description"
    t.float    "average_rating", :null => false
    t.text     "script"
    t.text     "miscellaneous"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  create_table "books_vendor_f10_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_vendor_f10_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "branches", :primary_key => "branch_id", :force => true do |t|
    t.integer  "city_id",     :null => false
    t.string   "branch_name", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  add_index "branches", ["branch_name", "city_id"], :name => "branch_name", :unique => true

  create_table "cities", :primary_key => "city_id", :force => true do |t|
    t.string   "city_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "cities", ["city_name"], :name => "city_name", :unique => true

  create_table "conversations", :primary_key => "conversation_id", :force => true do |t|
    t.string   "conversation", :null => false
    t.integer  "validity",     :null => false
    t.integer  "priority",     :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "conversations", ["conversation", "validity", "priority"], :name => "conversation", :unique => true

  create_table "filters_collections", :primary_key => "filters_collection_id", :force => true do |t|
    t.string   "filter_key",          :null => false
    t.integer  "filter_id",           :null => false
    t.string   "filter_table_name",   :null => false
    t.string   "filter_table_column", :null => false
    t.integer  "sub_category_id",     :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "filters_collections", ["filter_key", "filter_id", "filter_table_name", "filter_table_column"], :name => "filter_key", :unique => true

  create_table "fixed_pay_vendors", :force => true do |t|
    t.integer  "vendor_id",                      :null => false
    t.float    "accepted_amount",                :null => false
    t.date     "subscribed_date",                :null => false
    t.integer  "cut_off_period",                 :null => false
    t.integer  "history_flag",    :default => 0, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "fixed_pay_vendors", ["vendor_id"], :name => "vendor_id", :unique => true

  create_table "link_advertisers_lists_sub_categories", :primary_key => "link_id", :force => true do |t|
    t.integer  "advertiser_id",   :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_advertisers_lists_sub_categories", ["advertiser_id", "sub_category_id"], :name => "advertiser_id", :unique => true
  add_index "link_advertisers_lists_sub_categories", ["sub_category_id"], :name => "fk_link_advertisers_lists_sub_categories"

  create_table "link_books_lists_reviews", :force => true do |t|
    t.integer  "books_list_id",    :null => false
    t.integer  "books_reviews_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "link_books_lists_reviews", ["books_list_id"], :name => "books_list_id"
  add_index "link_books_lists_reviews", ["books_reviews_id"], :name => "books_reviews_id"

  create_table "link_f10_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",     :null => false
    t.integer  "secondary_camera_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "link_f10_mobiles_lists", ["mobiles_list_id", "secondary_camera_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f10_mobiles_lists", ["secondary_camera_id"], :name => "fk1_links_secondary_cameras"

  create_table "link_f10_vendor_books_lists", :force => true do |t|
    t.integer  "vendor_id",       :null => false
    t.integer  "books_list_id",   :null => false
    t.integer  "availability_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f10_vendor_books_lists", ["availability_id"], :name => "fk_link_f10_vendor_books_lists_availability"
  add_index "link_f10_vendor_books_lists", ["books_list_id"], :name => "fk_link_f10_vendor_books_lists"
  add_index "link_f10_vendor_books_lists", ["vendor_id", "books_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f11_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "processor_id",    :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f11_mobiles_lists", ["mobiles_list_id", "processor_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f11_mobiles_lists", ["processor_id"], :name => "fk1_links_processors"

  create_table "link_f12_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "messaging_id",    :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f12_mobiles_lists", ["messaging_id"], :name => "fk1_links_messagings"
  add_index "link_f12_mobiles_lists", ["mobiles_list_id", "messaging_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f13_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "browser_id",      :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f13_mobiles_lists", ["browser_id"], :name => "fk1_links_browsers"
  add_index "link_f13_mobiles_lists", ["mobiles_list_id", "browser_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f14_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "mobile_ram_id",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f14_mobiles_lists", ["mobile_ram_id"], :name => "fk1_links_mobile_rams"
  add_index "link_f14_mobiles_lists", ["mobiles_list_id", "mobile_ram_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f15_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "assorteds_id",    :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f15_mobiles_lists", ["assorteds_id"], :name => "fk1_links_assorteds"
  add_index "link_f15_mobiles_lists", ["mobiles_list_id", "assorteds_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f16_vendor_mobiles_lists", :force => true do |t|
    t.integer  "vendor_id",       :null => false
    t.integer  "mobiles_list_id", :null => false
    t.integer  "availability_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f16_vendor_mobiles_lists", ["availability_id"], :name => "fk1_links_availabilities"
  add_index "link_f16_vendor_mobiles_lists", ["mobiles_list_id"], :name => "fk1_links_mobiles_16"
  add_index "link_f16_vendor_mobiles_lists", ["vendor_id", "mobiles_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f1_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "author_id",     :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_books_lists", ["author_id"], :name => "fk_links_authors"
  add_index "link_f1_books_lists", ["books_list_id", "author_id"], :name => "books_list_id", :unique => true

  create_table "link_f1_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "mobile_brand_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_mobiles_lists", ["mobile_brand_id"], :name => "fk1_links_mobile_brands"
  add_index "link_f1_mobiles_lists", ["mobiles_list_id", "mobile_brand_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f2_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "genre_id",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_books_lists", ["books_list_id", "genre_id"], :name => "books_list_id", :unique => true
  add_index "link_f2_books_lists", ["genre_id"], :name => "fk_links_genres"

  create_table "link_f2_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "mobile_color_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_mobiles_lists", ["mobile_color_id"], :name => "fk1_links_mobile_colors"
  add_index "link_f2_mobiles_lists", ["mobiles_list_id", "mobile_color_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f3_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "isbn_id",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f3_books_lists", ["books_list_id", "isbn_id"], :name => "books_list_id", :unique => true
  add_index "link_f3_books_lists", ["isbn_id"], :name => "fk_links_isbns"

  create_table "link_f3_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "mobile_type_id",  :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f3_mobiles_lists", ["mobile_type_id"], :name => "fk1_links_mobile_types"
  add_index "link_f3_mobiles_lists", ["mobiles_list_id", "mobile_type_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f4_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "isbn13_id",     :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f4_books_lists", ["books_list_id", "isbn13_id"], :name => "books_list_id", :unique => true
  add_index "link_f4_books_lists", ["isbn13_id"], :name => "fk_links_isbn13s"

  create_table "link_f4_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",  :null => false
    t.integer  "mobile_design_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "link_f4_mobiles_lists", ["mobile_design_id"], :name => "fk1_links_mobile_designs"
  add_index "link_f4_mobiles_lists", ["mobiles_list_id", "mobile_design_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f5_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "binding_id",    :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_books_lists", ["binding_id"], :name => "fk_links_bindings"
  add_index "link_f5_books_lists", ["books_list_id", "binding_id"], :name => "books_list_id", :unique => true

  create_table "link_f5_c_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",           :null => false
    t.integer  "mobile_os_version_name_id", :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_c_mobiles_lists", ["mobiles_list_id", "mobile_os_version_name_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f5_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",      :null => false
    t.integer  "mobile_os_version_id", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_mobiles_lists", ["mobile_os_version_id"], :name => "fk1_links_operating_systems"
  add_index "link_f5_mobiles_lists", ["mobiles_list_id", "mobile_os_version_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f6_books_lists", :force => true do |t|
    t.integer  "books_list_id",      :null => false
    t.integer  "publishing_date_id", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at"
  end

  add_index "link_f6_books_lists", ["books_list_id", "publishing_date_id"], :name => "books_list_id", :unique => true
  add_index "link_f6_books_lists", ["publishing_date_id"], :name => "fk_links_publishing_dates"

  create_table "link_f6_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "touch_screen_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f6_mobiles_lists", ["mobiles_list_id", "touch_screen_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f6_mobiles_lists", ["touch_screen_id"], :name => "fk1_links_touch_screens"

  create_table "link_f7_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "publisher_id",  :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f7_books_lists", ["books_list_id", "publisher_id"], :name => "books_list_id", :unique => true
  add_index "link_f7_books_lists", ["publisher_id"], :name => "fk_links_publishers"

  create_table "link_f7_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",     :null => false
    t.integer  "internal_storage_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "link_f7_mobiles_lists", ["internal_storage_id"], :name => "fk1_links_internal_storages"
  add_index "link_f7_mobiles_lists", ["mobiles_list_id", "internal_storage_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f8_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "edition_id",    :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f8_books_lists", ["books_list_id", "edition_id"], :name => "books_list_id", :unique => true
  add_index "link_f8_books_lists", ["edition_id"], :name => "fk_links_editions"

  create_table "link_f8_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :null => false
    t.integer  "card_slot_id",    :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f8_mobiles_lists", ["card_slot_id"], :name => "fk1_links_card_slots"
  add_index "link_f8_mobiles_lists", ["mobiles_list_id", "card_slot_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f9_books_lists", :force => true do |t|
    t.integer  "books_list_id", :null => false
    t.integer  "language_id",   :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f9_books_lists", ["books_list_id", "language_id"], :name => "books_list_id", :unique => true
  add_index "link_f9_books_lists", ["language_id"], :name => "fk_links_languages"

  create_table "link_f9_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",   :null => false
    t.integer  "primary_camera_id", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "link_f9_mobiles_lists", ["mobiles_list_id", "primary_camera_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f9_mobiles_lists", ["primary_camera_id"], :name => "fk1_links_primary_cameras"

  create_table "link_products_lists_vendors", :primary_key => "unique_id", :force => true do |t|
    t.integer  "vendor_id",        :null => false
    t.integer  "products_list_id", :null => false
    t.integer  "sub_category_id",  :null => false
    t.integer  "availability_id",  :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "link_products_lists_vendors", ["availability_id"], :name => "fk_link_products_lists_vendors_ma"
  add_index "link_products_lists_vendors", ["products_list_id"], :name => "fk_link_products_lists_vendors_m"
  add_index "link_products_lists_vendors", ["sub_category_id"], :name => "fk_link_products_lists_vendors_sc"
  add_index "link_products_lists_vendors", ["vendor_id", "products_list_id", "sub_category_id"], :name => "vendor_id", :unique => true

  create_table "link_vendors_lists_branches", :force => true do |t|
    t.integer  "branch_id",  :null => false
    t.integer  "vendor_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_branches", ["branch_id"], :name => "fk_link_vendors_lists_branches_2"
  add_index "link_vendors_lists_branches", ["vendor_id", "branch_id"], :name => "vendor_id", :unique => true

  create_table "link_vendors_lists_cities", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "vendor_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_cities", ["city_id"], :name => "fk_link_vendors_lists_cities_2"
  add_index "link_vendors_lists_cities", ["vendor_id", "city_id"], :name => "vendor_id", :unique => true

  create_table "link_vendors_lists_sub_categories", :primary_key => "link_id", :force => true do |t|
    t.integer  "vendor_id",       :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_sub_categories", ["sub_category_id"], :name => "fk_link_vendors_lists_subcategories_sub_categories"
  add_index "link_vendors_lists_sub_categories", ["vendor_id", "sub_category_id"], :name => "vendor_id", :unique => true

  create_table "local_grid_details", :primary_key => "unique_id", :force => true do |t|
    t.float    "price",                       :null => false
    t.string   "availability",                :null => false
    t.string   "delivery",       :limit => 1, :null => false
    t.string   "delivery_time"
    t.float    "delivery_cost"
    t.text     "special_offers"
    t.text     "warranty"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "local_merchant_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
    t.integer  "part1_product_id",                                     :null => false
    t.integer  "vendor_id",                                            :null => false
    t.string   "vendor_table_name",                                    :null => false
    t.string   "action",                                               :null => false
  end

  add_index "local_merchant_products", ["vendor_id"], :name => "fk_local_merchant_products_vendors"

  create_table "merchants", :primary_key => "merchant_id", :force => true do |t|
    t.string   "login_name",    :null => false
    t.string   "password_hash", :null => false
    t.string   "password_salt", :null => false
    t.string   "table_name"
    t.string   "business_type", :null => false
    t.integer  "vendor_id",     :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "merchants", ["login_name"], :name => "login_name", :unique => true
  add_index "merchants", ["vendor_id"], :name => "fk_merchants_vendors"

  create_table "merchants_lists", :primary_key => "merchants_list_id", :force => true do |t|
    t.string   "merchant_name",                          :null => false
    t.text     "merchant_logo",                          :null => false
    t.text     "merchant_description"
    t.string   "business_type",                          :null => false
    t.string   "merchant_website",                       :null => false
    t.string   "merchant_email",                         :null => false
    t.string   "merchant_phone",                         :null => false
    t.string   "merchant_fax",         :default => "na"
    t.text     "merchant_address",                       :null => false
    t.string   "latitude",             :default => "na"
    t.string   "longitude",            :default => "na"
    t.string   "city_name"
    t.string   "branch_name"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants_lists", ["merchant_id"], :name => "merchant_id", :unique => true
  add_index "merchants_lists", ["merchant_name", "business_type", "city_name", "branch_name"], :name => "merchant_name", :unique => true
  add_index "merchants_lists", ["merchant_phone"], :name => "merchant_phone", :unique => true

  create_table "merchants_password_requests", :primary_key => "request_id", :force => true do |t|
    t.text     "request",                     :null => false
    t.string   "request_type",                :null => false
    t.integer  "merchant_id",                 :null => false
    t.integer  "served",       :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "metatags", :primary_key => "metatag_id", :force => true do |t|
    t.string   "metatag",         :null => false
    t.string   "model_name",      :null => false
    t.string   "column_name",     :null => false
    t.integer  "primary_id",      :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "metatags", ["model_name", "column_name", "primary_id"], :name => "model_name", :unique => true

  create_table "mobiles_f10_secondary_cameras", :primary_key => "secondary_camera_id", :force => true do |t|
    t.string   "secondary_camera", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f10_secondary_cameras", ["secondary_camera"], :name => "secondary_camera", :unique => true

  create_table "mobiles_f11_processors", :primary_key => "processor_id", :force => true do |t|
    t.string   "processor",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f11_processors", ["processor"], :name => "processor", :unique => true

  create_table "mobiles_f12_messagings", :primary_key => "messaging_id", :force => true do |t|
    t.string   "messaging_name", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f12_messagings", ["messaging_name"], :name => "messaging_name", :unique => true

  create_table "mobiles_f13_browsers", :primary_key => "browser_id", :force => true do |t|
    t.string   "browser_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f13_browsers", ["browser_name"], :name => "browser_name", :unique => true

  create_table "mobiles_f14_mobile_rams", :primary_key => "mobile_ram_id", :force => true do |t|
    t.string   "mobile_ram", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f14_mobile_rams", ["mobile_ram"], :name => "mobile_ram", :unique => true

  create_table "mobiles_f15_assorteds", :primary_key => "assorteds_id", :force => true do |t|
    t.string   "assorteds_name", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f15_assorteds", ["assorteds_name"], :name => "assorteds_name", :unique => true

  create_table "mobiles_f1_mobile_brands", :primary_key => "mobile_brand_id", :force => true do |t|
    t.string   "mobile_brand_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f1_mobile_brands", ["mobile_brand_name"], :name => "mobile_brand_name", :unique => true

  create_table "mobiles_f2_mobile_colors", :primary_key => "mobile_color_id", :force => true do |t|
    t.string   "mobile_color_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f2_mobile_colors", ["mobile_color_name"], :name => "mobile_color_name", :unique => true

  create_table "mobiles_f3_mobile_types", :primary_key => "mobile_type_id", :force => true do |t|
    t.string   "mobile_type_name", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f3_mobile_types", ["mobile_type_name"], :name => "mobile_type_name", :unique => true

  create_table "mobiles_f4_mobile_designs", :primary_key => "mobile_design_id", :force => true do |t|
    t.string   "mobile_design_name", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f4_mobile_designs", ["mobile_design_name"], :name => "mobile_design_name", :unique => true

  create_table "mobiles_f5_c_os_version_names", :primary_key => "mobile_os_version_name_id", :force => true do |t|
    t.string   "mobile_os_version_name", :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f5_c_os_version_names", ["mobile_os_version_name"], :name => "mobile_os_version_name", :unique => true

  create_table "mobiles_f5_os_versions", :primary_key => "mobile_os_version_id", :force => true do |t|
    t.string   "mobile_os_version",                        :null => false
    t.integer  "mobile_os_version_name_id", :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f5_os_versions", ["mobile_os_version", "mobile_os_version_name_id"], :name => "mobile_os_version", :unique => true

  create_table "mobiles_f6_touch_screens", :primary_key => "touch_screen_id", :force => true do |t|
    t.string   "touch_screen_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f6_touch_screens", ["touch_screen_name"], :name => "touch_screen_name", :unique => true

  create_table "mobiles_f7_internal_storages", :primary_key => "internal_storage_id", :force => true do |t|
    t.string   "internal_storage_name", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f7_internal_storages", ["internal_storage_name"], :name => "internal_storage_name", :unique => true

  create_table "mobiles_f8_card_slots", :primary_key => "card_slot_id", :force => true do |t|
    t.string   "card_slots", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f8_card_slots", ["card_slots"], :name => "card_slots", :unique => true

  create_table "mobiles_f9_primary_cameras", :primary_key => "primary_camera_id", :force => true do |t|
    t.string   "primary_camera", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f9_primary_cameras", ["primary_camera"], :name => "primary_camera", :unique => true

  create_table "mobiles_lists", :primary_key => "mobiles_list_id", :force => true do |t|
    t.string   "mobile_name",      :null => false
    t.text     "mobile_image_url"
    t.text     "mobile_features",  :null => false
    t.string   "mobile_brand",     :null => false
    t.string   "mobile_color",     :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_lists", ["mobile_name", "mobile_color"], :name => "mobile_name", :unique => true

  create_table "mobiles_vendor_f16_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_vendor_f16_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "online_flipkart_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  create_table "online_grid_details", :primary_key => "unique_id", :force => true do |t|
    t.float    "price",          :null => false
    t.text     "redirect_url",   :null => false
    t.string   "shipping_time",  :null => false
    t.float    "shipping_cost",  :null => false
    t.string   "availability",   :null => false
    t.text     "special_offers"
    t.text     "warranty"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  create_table "online_merchant_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
    t.integer  "part1_product_id",       :null => false
    t.integer  "vendor_id",              :null => false
    t.string   "vendor_table_name",      :null => false
    t.string   "action",                 :null => false
  end

  add_index "online_merchant_products", ["vendor_id"], :name => "fk_online_merchant_products_vendors"

  create_table "priority_errors", :force => true do |t|
    t.string   "product_sub_category", :null => false
    t.string   "product_name",         :null => false
    t.string   "identifier1",          :null => false
    t.string   "identifier2",          :null => false
    t.text     "message"
    t.integer  "count"
    t.integer  "fixed",                :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at"
  end

  create_table "priority_requests", :primary_key => "request_id", :force => true do |t|
    t.text     "request",                          :null => false
    t.string   "request_type",                     :null => false
    t.integer  "merchants_list_id",                :null => false
    t.integer  "served",            :default => 0, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at"
  end

  add_index "priority_requests", ["merchants_list_id"], :name => "merchants_list_id", :unique => true

  create_table "product_deals", :force => true do |t|
    t.integer  "vendor_id",       :null => false
    t.integer  "sub_category_id", :null => false
    t.integer  "product_id",      :null => false
    t.integer  "unique_id",       :null => false
    t.string   "business_type"
    t.text     "deal_info"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  create_table "product_purchase_commission_vendors", :force => true do |t|
    t.integer  "vendor_id",                          :null => false
    t.integer  "sub_category_id",                    :null => false
    t.integer  "purchase_commission",                :null => false
    t.date     "subscribed_date",                    :null => false
    t.float    "cut_off_amount",                     :null => false
    t.integer  "cut_off_period",                     :null => false
    t.integer  "history_flag",        :default => 0, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
  end

  add_index "product_purchase_commission_vendors", ["vendor_id", "sub_category_id"], :name => "vendor_id", :unique => true

  create_table "products_filter_collections", :primary_key => "filters_collection_id", :force => true do |t|
    t.string   "filter_key",          :null => false
    t.integer  "filter_id",           :null => false
    t.string   "filter_table_name",   :null => false
    t.string   "filter_table_column", :null => false
    t.integer  "sub_category_id",     :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "products_filter_collections", ["filter_key", "filter_id", "filter_table_name", "filter_table_column"], :name => "filter_key", :unique => true

  create_table "searches", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sms", :primary_key => "sms_id", :force => true do |t|
    t.integer  "product_id",                        :null => false
    t.integer  "sub_category_id",                   :null => false
    t.integer  "vendor_id",                         :null => false
    t.string   "landline_number", :default => "NA"
    t.string   "mobile_number",   :default => "NA"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
  end

  create_table "speak_to_us", :force => true do |t|
    t.string   "name",                                             :null => false
    t.string   "email",                                            :null => false
    t.string   "contact_number",                                   :null => false
    t.text     "message"
    t.string   "advertisement_flag", :limit => 1, :default => "n"
    t.string   "query_flag",         :limit => 1, :default => "n"
    t.string   "suggestion_flag",    :limit => 1, :default => "n"
    t.string   "defect_flag",        :limit => 1, :default => "n"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at"
  end

  create_table "stopwords", :primary_key => "stopword_id", :force => true do |t|
    t.string   "stopword",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "stopwords", ["stopword"], :name => "stopword", :unique => true

  create_table "subcategories", :primary_key => "sub_category_id", :force => true do |t|
    t.string   "sub_category_name", :null => false
    t.integer  "category_id",       :null => false
    t.string   "category_name",     :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_name", "sub_category_name"], :name => "category_name", :unique => true

  create_table "temp_transactions_logs", :primary_key => "log_id", :force => true do |t|
    t.integer  "unique_id",  :null => false
    t.string   "type",       :null => false
    t.date     "log_date",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  create_table "variable_pay_vendors", :force => true do |t|
    t.integer  "vendor_id",                                 :null => false
    t.float    "accepted_impressions_rate",                 :null => false
    t.float    "accepted_button_click_rate",                :null => false
    t.date     "subscribed_date",                           :null => false
    t.float    "cut_off_amount",                            :null => false
    t.integer  "cut_off_period",                            :null => false
    t.integer  "history_flag",               :default => 0, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at"
  end

  add_index "variable_pay_vendors", ["vendor_id"], :name => "vendor_id", :unique => true

  create_table "vendor_data_priorities", :force => true do |t|
    t.string   "vendor_table_name",    :null => false
    t.string   "product_name",         :null => false
    t.string   "product_identifier1",  :null => false
    t.string   "product_identifier2",  :null => false
    t.integer  "priority_errors_flag", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_deals", :force => true do |t|
    t.string   "sub_category",  :null => false
    t.string   "product_name",  :null => false
    t.string   "identifier1"
    t.string   "identifier2"
    t.string   "vendor_name",   :null => false
    t.string   "business_type", :null => false
    t.string   "city_name",     :null => false
    t.string   "branch_name",   :null => false
    t.text     "deal_info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_product_purchases_logs", :primary_key => "v_p_purch_log_id", :force => true do |t|
    t.integer  "vendor_id",               :null => false
    t.integer  "sub_category_id",         :null => false
    t.integer  "product_id",              :null => false
    t.integer  "product_purchase_count",  :null => false
    t.float    "product_purchase_amount", :null => false
    t.date     "log_date",                :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_product_transactions_logs", :primary_key => "v_p_trans_log_id", :force => true do |t|
    t.integer  "vendor_id",              :null => false
    t.integer  "sub_category_id",        :null => false
    t.integer  "product_id",             :null => false
    t.integer  "page_impressions_count", :null => false
    t.integer  "button_clicks_count",    :null => false
    t.date     "log_date",               :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  create_table "vendors_config_logs", :primary_key => "log_id", :force => true do |t|
    t.string   "configured_by",   :null => false
    t.string   "reason",          :null => false
    t.string   "validity",        :null => false
    t.integer  "product_id",      :null => false
    t.integer  "vendor_id",       :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  create_table "vendors_lists", :primary_key => "vendor_id", :force => true do |t|
    t.string   "vendor_name",                                            :null => false
    t.text     "vendor_logo",                                            :null => false
    t.text     "vendor_description",                                     :null => false
    t.string   "business_type",                                          :null => false
    t.string   "vendor_website",                       :default => "na"
    t.string   "vendor_email",                                           :null => false
    t.string   "vendor_phone",                                           :null => false
    t.string   "vendor_fax",                           :default => "na"
    t.text     "vendor_address",                                         :null => false
    t.string   "latitude",                             :default => "na"
    t.string   "longitude",                            :default => "na"
    t.string   "city_name",                                              :null => false
    t.string   "branch_name",                                            :null => false
    t.text     "working_time"
    t.text     "miscellaneous"
    t.string   "vendor_sub_categories", :limit => 500,                   :null => false
    t.string   "monetization_type",                                      :null => false
    t.date     "subscribed_date",                                        :null => false
    t.integer  "vendor_rating",                        :default => 0
    t.integer  "blocked_flag",                         :default => 0
    t.integer  "discarded_flag",                       :default => 0
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
  end

  add_index "vendors_lists", ["vendor_name", "business_type", "city_name", "branch_name"], :name => "vendor_name", :unique => true
  add_index "vendors_lists", ["vendor_phone"], :name => "vendor_phone", :unique => true

end

class AddForeignKeyToBookIndexLinkTables < ActiveRecord::Migration
   def up

    execute <<-SQL
      ALTER TABLE link_f1_books_lists
        ADD CONSTRAINT fk_links_books
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f1_books_lists
        ADD CONSTRAINT fk_links_authors
        FOREIGN KEY (author_id)
        REFERENCES books_f1_authors(author_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f2_books_lists
        ADD CONSTRAINT fk_links_books_2
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f2_books_lists
        ADD CONSTRAINT fk_links_genres
        FOREIGN KEY (genre_id)
        REFERENCES books_f2_genres(genre_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f3_books_lists
        ADD CONSTRAINT fk_links_books_3
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f3_books_lists
        ADD CONSTRAINT fk_links_isbns
        FOREIGN KEY (isbn_id)
        REFERENCES books_f3_isbns(isbn_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f4_books_lists
        ADD CONSTRAINT fk_links_books_4
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f4_books_lists
        ADD CONSTRAINT fk_links_isbn13s
        FOREIGN KEY (isbn13_id)
        REFERENCES books_f4_isbn13s(isbn13_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f5_books_lists
        ADD CONSTRAINT fk_links_books_5
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f5_books_lists
        ADD CONSTRAINT fk_links_bindings
        FOREIGN KEY (binding_id)
        REFERENCES books_f5_bindings(binding_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f6_books_lists
        ADD CONSTRAINT fk_links_books_6
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f6_books_lists
        ADD CONSTRAINT fk_links_publishing_dates
        FOREIGN KEY (publishing_date_id)
        REFERENCES books_f6_publishing_dates(publishing_date_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f7_books_lists
        ADD CONSTRAINT fk_links_books_7
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f7_books_lists
        ADD CONSTRAINT fk_links_publishers
        FOREIGN KEY (publisher_id)
        REFERENCES books_f7_publishers(publisher_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f8_books_lists
        ADD CONSTRAINT fk_links_books_8
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f8_books_lists
        ADD CONSTRAINT fk_links_editions
        FOREIGN KEY (edition_id)
        REFERENCES books_f8_editions(edition_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f9_books_lists
        ADD CONSTRAINT fk_links_books_9
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f9_books_lists
        ADD CONSTRAINT fk_links_languages
        FOREIGN KEY (language_id)
        REFERENCES books_f9_languages(language_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f10_vendor_books_lists
        ADD CONSTRAINT fk_link_f10_vendor_books_lists
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f10_vendor_books_lists
        ADD CONSTRAINT fk_link_f10_vendor_books_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES books_vendor_f10_availabilities(availability_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f10_vendor_books_lists
        ADD CONSTRAINT fk_link_f10_vendor_books_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_books_lists_reviews
        ADD CONSTRAINT fk_link_books_lists_reviews_1
        FOREIGN KEY (books_list_id)
        REFERENCES books_lists(books_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_books_lists_reviews
        ADD CONSTRAINT fk_link_books_lists_reviews_2
        FOREIGN KEY (books_reviews_id)
        REFERENCES books_reviews(id)
    SQL

  end

  def down
    execute "ALTER TABLE link_f1_books_lists DROP FOREIGN KEY fk_links_books"
    execute "ALTER TABLE link_f1_books_lists DROP FOREIGN KEY fk_links_authors"
    execute "ALTER TABLE link_f2_books_lists DROP FOREIGN KEY fk_links_books_2"
    execute "ALTER TABLE link_f2_books_lists DROP FOREIGN KEY fk_links_genres"
    execute "ALTER TABLE link_f3_books_lists DROP FOREIGN KEY fk_links_books_3"
    execute "ALTER TABLE link_f3_books_lists DROP FOREIGN KEY fk_links_isbns"
    execute "ALTER TABLE link_f4_books_lists DROP FOREIGN KEY fk_links_books_4"
    execute "ALTER TABLE link_f4_books_lists DROP FOREIGN KEY fk_links_isbn13s"
    execute "ALTER TABLE link_f5_books_lists DROP FOREIGN KEY fk_links_books_5"
    execute "ALTER TABLE link_f5_books_lists DROP FOREIGN KEY fk_links_bindings"
    execute "ALTER TABLE link_f6_books_lists DROP FOREIGN KEY fk_links_books_6"
    execute "ALTER TABLE link_f6_books_lists DROP FOREIGN KEY fk_links_publishing_dates"
    execute "ALTER TABLE link_f7_books_lists DROP FOREIGN KEY fk_links_books_7"
    execute "ALTER TABLE link_f7_books_lists DROP FOREIGN KEY fk_links_publishers"
    execute "ALTER TABLE link_f8_books_lists DROP FOREIGN KEY fk_links_books_8"
    execute "ALTER TABLE link_f8_books_lists DROP FOREIGN KEY fk_links_editions"
    execute "ALTER TABLE link_f9_books_lists DROP FOREIGN KEY fk_links_books_9"
    execute "ALTER TABLE link_f9_books_lists DROP FOREIGN KEY fk_links_languages"
    execute "ALTER TABLE link_f10_vendor_books_lists DROP FOREIGN KEY fk_link_f10_vendor_books_lists"
    execute "ALTER TABLE link_f10_vendor_books_lists DROP FOREIGN KEY fk_link_f10_vendor_books_lists_availability"
    execute "ALTER TABLE link_f10_vendor_books_lists DROP FOREIGN KEY fk_link_f10_vendor_books_lists_vendor"
    execute "ALTER TABLE link_books_lists_reviews DROP FOREIGN KEY fk_link_books_lists_reviews_2"
    execute "ALTER TABLE link_books_lists_reviews DROP FOREIGN KEY fk_link_books_lists_reviews_1"

  end
end


module SearchHelper

  def decide_search_form

    if @search_case == "products"

      html = render ('shared/form')

  elsif @search_case == "price"

      html = render ('price_search/form')

    end

    html

  end

  def get_counts

    self.set_book_mobile_count

      if !(@book_count == 0) && !(@mobile_count == 0)

        total_count = @book_count + @mobile_count

        category_count = 2

      elsif !(@book_count == 0) && (@mobile_count == 0)

        total_count = @book_count

        category_count = 1

      elsif (@book_count == 0) && !(@mobile_count == 0)

        total_count = @mobile_count

        category_count = 1

      else

        total_count = 0

        category_count = 0

      end

     [total_count,category_count]

  end

  def get_current_counts(sub_category_id)

    self.set_book_mobile_count

    @sub_categories.each do |i|

      if i.sub_category_id == sub_category_id

        if i.sub_category_name == "books_lists"

          @total_count = @book_count

          @name = "Books"

        elsif i.sub_category_name == "mobiles_lists"

          @total_count = @mobile_count

          @name = "Mobiles"

        end

      end

    end

    [@total_count,@name]

  end

  def set_book_mobile_count

    @book_count = @books_all_count.to_i

    @mobile_count = @mobiles_all_count.to_i

  end

end


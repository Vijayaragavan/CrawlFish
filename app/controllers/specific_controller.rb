class SpecificController < ApplicationController

  include SpecificHelper

  include SearchHelper

# functions defined after this section are direct
#================ Direct Functions - START ================
  def index

  end

  def specific_search #This function is called when a request from generic page arrives.

    set_sub_categories# called from application controller because the same method is also called in many other places

    self.set_instance_variables

    self.set_specific_product_id_sub_category_id

    set_sub_category_name(@sub_category_id)# called from application controller because the same method is also called in bnm_controller
    set_product# called from application controller because the same method is also called in local_controller

    self.set_feature_name_image

    self.set_area_id

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    set_excludable_availability_ids(1) # called from application controller because the same method is also called in bnm_controller

    self.set_grid_and_count("online")

    self.set_grid_and_count("local")

    self.set_starts_at

    self.set_similar_product_id(@product_id,@sub_category_id)

    self.set_similar_product

    self.get_deals

    render ('specific')

  end


  def include_exclude_view_all_local #This function is called when an ajax request from include/exclude out-of-stocks links are clicked in books and mobiles categories for online and local vendors & view_all_local link is clicked

     set_sub_categories# called from application controller because the same method is also called in many other places

     self.set_product_id_sub_category_id

     set_sub_category_name(@sub_category_id)# called from application controller because the same method is also called in bnm_controller

     set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

     self.set_include

     self.set_type

     self.set_area_id

     set_excludable_availability_ids(@include)# called from application controller because the same method is also called in bnm_controller

     self.set_page

     self.set_grid_and_count(@type)

    render :partial => "specific/"+@type

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_starts_at

    if !params[:starts_at].nil?

      @starts_at = params[:starts_at].to_f

    else

      @starts_at = get_available_from_final([@product_id],@sub_category_id).map {|i| i[1]}.join.to_i

    end


  end

  def set_include

    if !params[:include].nil?

      @include = params[:include].to_i

    end

  end


  def set_page

    if params[:page].to_i == 0

      @page = 1

    else

      @page = params[:page].to_i

    end

  end

  def set_type

    if !params[:type].nil?

      @type = params[:type].to_s

    end

  end

  def set_area_id

    if !params[:area_id].nil?

      @area_id = params[:area_id].to_i

    else

      @area_id = 0

    end

  end

  def set_grid_and_count(grid_type)

    if grid_type == "online"

       @online_grids = OnlineGridDetails.get_grid(@product_id,@sub_category_id,@excludable_availability_ids).paginate(:per_page => 3, :page => @page)
       @online_grids_count = @online_grids.total_entries

    elsif grid_type == "local"

      if (@excludable_availability_ids.empty?)

        @excludable_availability_ids = 0

      end

       @local_grids = LocalGridDetails.get_grid(@product_id,@sub_category_id,@excludable_availability_ids,@area_id).paginate(:per_page => 3, :page => @page)
       @local_grids_count = @local_grids.total_entries

    end

  end

  def set_feature_name_image

    if @sub_category_name == "books_lists"

              @product.each do |book|

                  @feature_array = book.book_features.split("#")
                  @product_name = book.book_name
                  @product_image_url = book.book_image_url
		  @desc_rating_widget=BooksReviews.where(:isbn13 => book.isbn13).map {|i| [i.description,i.average_rating,i.script]}.flatten

              end

    elsif @sub_category_name == "mobiles_lists"

              @product.each do |mobile|

                  @feature_array = mobile.mobile_features.split("#")
                  @product_name = mobile.mobile_name
                  @product_image_url = mobile.mobile_image_url

              end

    end

  end

  def set_similar_product_id(product_id,sub_category_id)

    if @sub_category_name == "books_lists"

      @similar_product_id = LinkF2BooksLists.get_similar_books_list_id(product_id,sub_category_id)

    elsif @sub_category_name == "mobiles_lists"

      @similar_product_id = self.find_similar_mobiles_list_id(product_id,sub_category_id)

    end

  end

  def set_similar_product

    if @sub_category_name == "books_lists"

      @similar_product = BooksList.fetch_exact_match(@similar_product_id)

    elsif @sub_category_name == "mobiles_lists"

      @similar_product = MobilesLists.fetch_exact_match(@similar_product_id)

    end

  end


  def set_instance_variables

     @cities = Cities.find(:all)
     @areas = []
     @feature_array = Array.new
     @online_grids = Array.new
     @local_grids = Array.new
     @desc_rating_widget=Array.new

     @online_deal=Array.new
     @local_deal=Array.new
     @online_deal_product_details=Array.new
     @local_deal_product_details=Array.new
  end

  def set_specific_product_id_sub_category_id

       if !params[:specific_product_id].nil?

        @product_id = params[:specific_product_id].to_i

       elsif !params[:product][:id].nil?

         @product_id = params[:product][:id].to_i

       end

      if  !params[:sub_category_id].nil?

        @sub_category_id = params[:sub_category_id].to_i

      end

  end

  def set_product_id_sub_category_id

    if !params[:product_id].nil? && !params[:sub_category_id].nil?

        @product_id = params[:product_id].to_i
        @sub_category_id = params[:sub_category_id].to_i

    end

  end

  def get_deals

	@online_deal = 	ProductDeals.get_online_deal
	@local_deal = 	ProductDeals.get_local_deal

        @online_deal.each do |i|

		if i.sub_category_id == 1

			@online_deal_product_details = BooksList.fetch_exact_match(i.product_id)

			i.redirect_url = get_valid_url(i.redirect_url)

		elsif i.sub_category_id == 2

			@online_deal_product_details = MobilesLists.fetch_exact_match(i.product_id)

			i.redirect_url = get_valid_url(i.redirect_url)

		end
 	end

	@local_deal.each do |i|

		if i.sub_category_id == 1

			@local_deal_product_details = BooksList.fetch_exact_match(i.product_id)

		elsif i.sub_category_id == 2

			@local_deal_product_details = MobilesLists.fetch_exact_match(i.product_id)

		end
 	end


  end

  def get_valid_url(url)

    /^http/.match(url) ? url : "http://#{url}"

  end

  def find_similar_mobiles_list_id(product_id,sub_category_id)

    debug(@starts_at)

    price_unique_id =  General.get_unique_id_between_given_price(@starts_at)

    brand_unique_id = LinkF1MobilesLists.get_similar_brand_unique_id(product_id,sub_category_id,price_unique_id)

    design_unique_id = LinkF4MobilesLists.get_similar_design_unique_id(product_id,sub_category_id,brand_unique_id)

    if design_unique_id.size >= 1

      unique_id = design_unique_id.sample

    elsif design_unique_id.size == 0

      if brand_unique_id.size >= 1

        unique_id = brand_unique_id.sample

      elsif brand_unique_id.size == 0

        unique_id = price_unique_id.sample

      end

    end

    LinkProductsListsVendors.get_products_list_id_from_unique_id(unique_id).products_list_id

  end
#================ Auxillary Functions - END================

end


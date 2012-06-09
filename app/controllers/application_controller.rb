class ApplicationController < ActionController::Base

  protect_from_forgery

  include RubyUtilities

  include SearchModule

   unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end


    # functions defined after this section are used for search both in regular search and price search
#================ SEARCH - START ================

  def debug(variable)

    puts "#################################################################################"

    puts "===START==="

    puts variable

    puts "===END==="

    puts "#################################################################################"

  end

   def error_log(error_message,code = 1)

    puts "XXXXXXX==ERROR MESSAGE START==XXXXXXXXX"

    puts "LOGGED MESSAGE : #{error_message}, CODE : #{code}, at #{Time.now}"

    puts "XXXXXXX==ERROR MESSAGE END==XXXXXXXXX"

  end

  def create_master_hash

    @sub_categories.each do |i|

      @master_hash[i.sub_category_id][:join] = []

      @master_hash[i.sub_category_id][:title] = []

      @master_hash[i.sub_category_id][:filter] = []

      @master_hash[i.sub_category_id][:final] = []

    end

  end

  def set_sub_categories#this will set the @sub_categories variable with all the records in Subcategories table.

    @sub_categories = Subcategories.all

  end

  def set_query_as_nil

    params[:query] = nil

  end

  def form_products_list_id_hash

    @master_hash.keys.each do |sub_category_id|

      @products_list_id_hash[sub_category_id] = LinkProductsListsVendors.get_products_list_id(sub_category_id)

    end

  end


 def set_master_hash_from_generic_view

   @sub_categories.each do |i|

      @master_hash[i.sub_category_id][:final] =  Search.get_products_list_id(@view_name,i.sub_category_id)

    end

  end

   def render_categories_filters

          @master_hash.keys.each do |sub_category_id|

            if !(@master_hash[sub_category_id][:final].flatten.empty?)

              self.loop_categories(sub_category_id)

            end

          end
   end


   def loop_categories(sub_category_id)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count.

     puts "+++++++ApplicationController/loop_categories++++++++++"

     @sub_categories.each do |i|

       if i.sub_category_id == sub_category_id


                  if i.sub_category_name == 'books_lists'

                    puts "++++++++matched and found the sub_category as #{i.sub_category_name}+++++++++"

                    set_products_count(sub_category_id)

                    puts "++++++++Value of @books_all #{@books_all}+++++++++"

                    puts "+++++-- Values of @page is #{@page}--++++"

                    @books = @books_all.paginate(:per_page => 10, :page => @page)

		                @available_from_final[i.sub_category_id] = get_available_from_final(@books.flatten.map {|v| v.books_list_id},i.sub_category_id)

                    puts "++++++++Value of @books #{@books}+++++++++"

                    self.books_filters

                  end

                  if i.sub_category_name == 'mobiles_lists'

                    puts "++++++++matched and found the sub_category as #{i.sub_category_name}+++++++++"

                    set_products_count(sub_category_id)

                    puts "++++++++Value of @mobiles_all #{@mobiles_all}+++++++++"

                    @mobiles = @mobiles_all.paginate(:per_page => 10, :page => @page)

             		    @available_from_final[i.sub_category_id] = get_available_from_final(@mobiles.flatten.map {|v| v.mobiles_list_id},i.sub_category_id)

		                puts "available_from_final #@available_from_final"

	                  puts "#########"

                    puts "++++++++Value of @mobiles #{@mobiles}+++++++++"

                    self.mobiles_filters

                  end
       end

     end

   end

   def set_products_count(sub_category_id)

         @sub_categories.each do |i|

           if i.sub_category_id == sub_category_id

            if i.sub_category_name == "books_lists"

		if !@master_hash[i.sub_category_id][:final].flatten.empty?

                @books_all = BooksList.where("books_list_id IN (?)",@master_hash[i.sub_category_id][:final].flatten).order(" FIELD "+"(books_list_id,#{@master_hash[i.sub_category_id][:final].flatten.join(",")})")

                @books_all_count = @books_all.size.to_s

		end

            elsif i.sub_category_name == "mobiles_lists"

		if !@master_hash[i.sub_category_id][:final].flatten.empty?

             @mobiles_all = MobilesLists.where("mobiles_list_id IN (?)",@master_hash[i.sub_category_id][:final].flatten).order(" FIELD "+"(mobiles_list_id,#{@master_hash[i.sub_category_id][:final].flatten.join(",")})").group("mobile_name")

		@mobiles_all_count = @mobiles_all.size.size.to_s

                end

            end

          end

         end

   end


   def books_filters

               @genres = General.get_filter_id_name_count(@books_all.flatten.map {|v| v.books_list_id},"genre_id","genre_name","books_f2_genres","books_list_id","link_f2_books_lists")

               @bindings = General.get_filter_id_name_count(@books_all.flatten.map {|v| v.books_list_id},"binding_id","binding_name","books_f5_bindings","books_list_id","link_f5_books_lists")

               @publishers = General.get_filter_id_name_count(@books_all.flatten.map {|v| v.books_list_id},"publisher_id","publisher","books_f7_publishers","books_list_id","link_f7_books_lists")

               @languages = General.get_filter_id_name_count(@books_all.flatten.map {|v| v.books_list_id},"language_id","language_name","books_f9_languages","books_list_id","link_f9_books_lists")

   end

   def mobiles_filters

               @mobile_brands = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"mobile_brand_id","mobile_brand_name","mobiles_f1_mobile_brands","mobiles_list_id","link_f1_mobiles_lists")

               @mobile_types = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"mobile_type_id","mobile_type_name","mobiles_f3_mobile_types","mobiles_list_id","link_f3_mobiles_lists")

               @mobile_designs = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"mobile_design_id","mobile_design_name","mobiles_f4_mobile_designs","mobiles_list_id","link_f4_mobiles_lists")

               @mobile_os_version = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"mobile_os_version_id","mobile_os_version","mobiles_f5_os_versions","mobiles_list_id","link_f5_mobiles_lists")

               @primary_cameras = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"primary_camera_id","primary_camera","mobiles_f9_primary_cameras","mobiles_list_id","link_f9_mobiles_lists")

              @secondary_cameras = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"secondary_camera_id","secondary_camera","mobiles_f10_secondary_cameras","mobiles_list_id","link_f10_mobiles_lists")

               @assorteds = General.get_filter_id_name_count(@mobiles_all.flatten.map {|v| v.mobiles_list_id},"assorteds_id","assorteds_name","mobiles_f15_assorteds","mobiles_list_id","link_f15_mobiles_lists")

   end

   def set_page(from_pagination,page)

     if !(from_pagination.nil?)

      if from_pagination.to_i == 1

        @page = page

      else

        @page = 1

      end

    end

   end

   def form_master_hash_final

    @master_hash.keys.each do |sub_category_id|

       if !(@master_hash[sub_category_id][:title].flatten.empty?) && !(@master_hash[sub_category_id][:filter].flatten.empty?) && !(@master_hash[sub_category_id][:join].flatten.empty?)

          @master_hash[sub_category_id][:final] = (@master_hash[sub_category_id][:join].flatten + @master_hash[sub_category_id][:title].flatten ).uniq

        elsif !(@master_hash[sub_category_id][:title].flatten.empty?) && !(@master_hash[sub_category_id][:filter].flatten.empty?) && (@master_hash[sub_category_id][:join].flatten.empty?)

          @master_hash[sub_category_id][:final] =  @master_hash[sub_category_id][:title].flatten

        elsif !(@master_hash[sub_category_id][:title].flatten.empty?) && (@master_hash[sub_category_id][:filter].flatten.empty?)

          @master_hash[sub_category_id][:final] =  @master_hash[sub_category_id][:title].flatten

        elsif (@master_hash[sub_category_id][:title].flatten.empty?) && !(@master_hash[sub_category_id][:filter].flatten.empty?)

          @master_hash[sub_category_id][:final] =  @master_hash[sub_category_id][:filter].flatten

        elsif (@master_hash[sub_category_id][:title].flatten.empty?) && (@master_hash[sub_category_id][:filter].flatten.empty?)

        @sub_categories.each do |i|

          if i.sub_category_id == sub_category_id

            if i.sub_category_name == "books_lists"

              @no_books_flag = 1

            elsif i.sub_category_name == "mobiles_lists"

              @no_mobiles_flag = 1

            end

          end

        end

       end

    end


  end

  def set_category_order(from_search_controller,clicked = 0)# this method sets the category order, if from_search_controller variable is set to 1, then it sorts the order listing the max number at top. If clicked is set to 1, then clicked_category will be set to sub_category_flag to highlight the current clicked category

    if !(clicked == 0)

      @clicked_category = @sub_category_flag

    end

        set_sub_categories

        count = Hash.new

        @master_hash.keys.each do |sub_category_id|

          set_sub_category_name(sub_category_id)

          if @sub_category_name == "books_lists"

            count[sub_category_id] = @books_all_count

          elsif @sub_category_name == "mobiles_lists"

            count[sub_category_id] = @mobiles_all_count

          end

        end

        if from_search_controller == 1

          @category_order = count.sort_by {|k,v| v.to_i}.map{|i| i[0].to_i}.reverse

        else

          @category_order = count.map{|i| i[0].to_i}

        end

  end

  def get_available_from_final(product_ids_array,sub_category_id)

     set_sub_category_name(sub_category_id)

    #Senthil: removed exclude_availabilities_array since, availablility should be handled in specific page and
    #because of handling it here, some products shows up without price.

     #set_excludable_availability_ids(1)

     General.get_lowest_price(product_ids_array,sub_category_id)

  end

  def order_products_id(actual)

        actual.flatten.group_by{|x| x}.sort_by{|k, v| -v.size}.map(&:first)

  end

  def validate_searchkey(searchkey)# this method is usead both in regular search and price search.

    if searchkey.empty?

      @message = 'No search key entered!'
      render ('shared/no_results')
      return false

    elsif searchkey.gsub(/[ ]/i, '').empty?

      @message = 'Entered only spaces!'
      render ('shared/no_results')
      return false

    elsif searchkey.gsub(/[^A-Za-z0-9]/,"").empty?

     @message = 'Entered only symbols!'
     render ('shared/no_results')
     return false

    end

    return true

  end

  def set_session_variables

        session[:current_id] = request.session_options[:id]
        session[:generic_view_name] = "generic"+session[:current_id]
        session[:order] = 0

  end

  def set_search_case# the purpose of this method is to set the search_type params to an instance variable in all the pages of crawlfish public users to determine which search box should be rendered.
  # there is a reason behind why it is search_case and not search_type. It is, in specific_page, during pagination of the grids, a url regexp match is done in jQuery to find the parameter "type". If you keep search_type, this interferes with it.

    if !(params[:search_case].nil?)

      @search_case = params[:search_case].to_s

    else

      error_log("params[:search_case] was nil")

    end

  end

#================ SEARCH - END ================

# functions defined after this section are used by merchants
#================ MERCHANTS - START ================


  def merchants_home_preliminary_actions

    @merchants_list = MerchantsLists.new
    @merchant = Merchants.new
    @areas = []

  end

  def login_required
    if session[:merchant_id]
      return true
    end
    flash[:notice]='Please login to continue'
    #session[:return_to]=request.request_uri
    redirect_to :controller => "merchants", :action => "home"
    return false
  end


  def current_merchant
    if !(session[:merchant_id].nil?)

       @current_merchant ||=  Merchants.find(session[:merchant_id])

    else

       @current_merchant = nil

    end
  end


  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

#================ MERCHANTS - END ================

# functions defined after this section are used generally
#================ GENERAL - START ================


  def to_u(input)

    input.gsub!(/(.)([A-Z])/,'\1_\2').downcase!

  end

  def f_stripstring(input)

    input.downcase.squeeze(" ").gsub(/ /,"").gsub(/,.-/,"")

  end

#================ GENERAL - END ================

# functions defined after this section are used in specific_search
#================ SPECIFIC SEARCH - START ================
  def set_excludable_availability_ids(include)

    if include == 1

        if @sub_category_name == "books_lists"

          @excludable_availability_ids = get_availability_ids(["out of stock","permanently discontinued"])

        elsif @sub_category_name == "mobiles_lists"

          @excludable_availability_ids = get_availability_ids(["out of stock"])

        end

    elsif include == 0

        if @sub_category_name == "books_lists"

          @excludable_availability_ids = get_availability_ids(["permanently discontinued"])

        elsif @sub_category_name == "mobiles_lists"

          @excludable_availability_ids = get_availability_ids

        end

    end

  end

  def set_sub_category_name(sub_category_id)

    @sub_categories.each do |i|

        if i.sub_category_id == sub_category_id

            @sub_category_name = i.sub_category_name

        end

     end

  end

  def get_availability_ids(exclude_availabilities_array = ["default"])

    if @sub_category_name == "books_lists"

       BooksVendorF10Availabilities.get_availability_ids(exclude_availabilities_array)

      elsif @sub_category_name == "mobiles_lists"

        MobilesVendorF16Availabilities.get_availability_ids(exclude_availabilities_array)

      end

  end

  def set_product

    if @sub_category_name == "books_lists"

       @product =  BooksList.fetch_exact_match(@product_id)

    elsif @sub_category_name == "mobiles_lists"

       @product =  MobilesLists.fetch_exact_match(@product_id)

    end

  end
#================ SPECIFIC SEARCH - END ================



end


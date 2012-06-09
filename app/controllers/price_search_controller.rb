class PriceSearchController < ApplicationController

# A price search is noting but getting the unique from online/local_grid details and then using that to retrieve the products_list_id and sub_category_id and filling the master_hash only to render a generic search.
# User can choose the sub_category_id and business_type.
#================ DIRECT METHODS START ================

  def index

    set_sub_categories

  end

  def start_search

   
    self.create_instance_variables# this method creates the necessary instance variables for price_search which actually renders generic search page.

    set_sub_categories# called from application_controller, sets @sub_categories with all available categories

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_session_variables#In this, all the session variables are being set, mainly the session id is concatenated with "generic" which will be used for this sessions view name.

     set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

     set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    self.set_view_name#@view_name is set from session[:generic_view_name]

    self.set_price_query_type_sub_category_flag#these are very important params from the form of the price search. they are set as instance variables in this method. price_query, sub_category_flag, type.

    if (self.validate_price_query_set_unique_ids)# validates the price_query and sets the @unique_ids variable by calling next level auxillary methods.

     @message = 'No products found!'
     return render ('price_search/no_results')

    else

     self.set_products_list_id_sub_category_id# from @unique_ids array the @products_list_id_sub_category_id is set by doing a mysql select on link_products_lists_vendors

    if self.fill_master_hash#a simple iteration on the array created in the previous step is done and @master_hash is filled up.

      render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts.

      set_category_order(1)# This method is called from application_controller, decides which category has to be listed first.

      Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

     render ('search/generic')

   else

     @message = 'No products found!'
     render ('price_search/no_results')

    end

   end

  end

#================ DIRECT METHODS - END ================

# functions defined after this section are auxillary -1 methods used by direct methods.
#================ AUXILLARY- 1 - START ================

  def set_view_name

    if !(session[:generic_view_name].nil?)

      @view_name = session[:generic_view_name]

    else

      error_log("session[:generic_view_name] was nil",2)

    end

  end

  def create_instance_variables

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @available_from_final = Hash.new

    @products_list_id_sub_category_id = []

  end

  def set_price_query_type_sub_category_flag

    if !(params[:price_query].nil?)

      @price_query = params[:price_query]

    else

        error_log("params[:price_query] was empty")

    end

    if !(params[:type].nil?)

      self.set_type_from_params_type

    else

        error_log("params[:type] was empty")

    end

    if !(params[:sub_category_flag].nil?)

      @sub_category_id_params = params[:sub_category_flag].to_i

    else

       error_log("params[:sub_category_flag] was empty")

    end

  end

  def validate_price_query_set_unique_ids

    if validate_searchkey(@price_query)

      self.strip_price_query

      self.set_gap_unique_ids

      if !(self.set_unique_ids)

        return false

      end

    end

  end

  def set_products_list_id_sub_category_id

    if !(@unique_ids.empty?)

     @products_list_id_sub_category_id = LinkProductsListsVendors.get_products_list_id_sub_category_id_from_unique_id(@unique_ids,@sub_category_id_params)

     else

        error_log("@unique_ids was empty")

    end

  end

  def fill_master_hash

    if !(@products_list_id_sub_category_id.empty?)

        @products_list_id_sub_category_id.each do |i|

          @master_hash[i.sub_category_id][:final] << i.products_list_id

        end

        return true

    else

        error_log("@products_list_id_sub_category_id was empty")

        return false

    end

  end

#================ AUXILLARY- 1 - END ================

#These methods are used by auxillary - 1 methods
#================ AUXILLARY- 2 - START ================

  def strip_price_query

    @price_query = @price_query.split(".")[0].scan(/[0-9]+/).join.to_i
    session[:query] = @price_query

  end

  def set_gap_unique_ids

    @unique_ids = []

    for i in (0..9)

       if @price_query.between?(i * 1000,(i + 1)  * 1000)

         @gap = (((i + 1)  * 100)/2).to_i

         return

       else

         @gap = 1000.to_i

       end

    end

  end

  def set_unique_ids

    counter = 1

    while (@unique_ids.empty?) do

       @unique_ids =  General.get_unique_id_between_given_price(@price_query,@gap,@type)

       self.increase_gap

       counter = counter + 1

       if counter == 5

         return false

       end

    end

  end

  def set_type_from_params_type

    params_type = params[:type].to_i

      if params_type == 0

        @type = "both"

      elsif params_type == 1

        @type = "local"

      elsif params_type == 2

        @type = "online"

      end

  end

#================ AUXILLARY- 2 - END ================

#These methods are used by auxillary - 2 methods
#================ AUXILLARY- 3 - START ================
  def increase_gap

    @gap = @gap + 50

  end
#================ AUXILLARY- 3 - END ================

end


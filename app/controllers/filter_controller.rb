class FilterController < ApplicationController

  include FilterHelper

  # functions defined after this section are direct
#================ Direct Functions - START ================

  def filters

    #preliminary_actions

    self.create_instance_variables_for_filters# create the instance variables that are totally necessary for the filtering the search results.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    puts "++++++++++++++--FilterController--+++++++++++++++"

    puts "BEFORE set_master_hash_from_generic_view, master_hash is...#{@master_hash}.."

    puts "View #{@view_name} ALREADY EXIST..."

    set_master_hash_from_generic_view# The master_hash which was created in the create_instance_variables method will be set from the generic_view based on the data present in the view_name procured from the url parameter as params[:view_name]

    @filter_extended_params = parse_params(params)#The url parameters will be parsed by this method and it will return an extended_params which will be used in the next step for proceeding with the filtering process. This is done because the url parameters are not so clean and it is prone to have duplicates.

    puts "AFTER set_master_hash_from_generic_view, master_hash is...#{@master_hash}.."

    puts "+++++++Filter/filters++++++++++"

    puts "sub_category_flag is #{@sub_category_flag}.."

    puts "@filter_extended_params is #{@filter_extended_params}.."

    @sub_categories.each do |i|

    if i.sub_category_id == @sub_category_flag

      if  i.sub_category_name == 'books_lists'

         puts "++++++++matched and found the sub_category as #{i.sub_category_name}+++++++++"

         puts "+++++++++master_hash before fetch_products_list_id #{@master_hash}.."

          puts "+++-- the value of filter_extended_params is #{@filter_extended_params}.."

          @master_hash[@sub_category_flag][:final] = Search.fetch_products_list_id(@filter_extended_params,@master_hash[@sub_category_flag][:final].flatten.map {|x| x},"books_list_id","books_lists")#This method is located in the Search model which is for the mysql sub_queries based on the extended_params.

           puts "+++++++++master_hash after fetch_products_list_id #{@master_hash}.."


      elsif i.sub_category_name	 == 'mobiles_lists'

         puts "++++++++matched and found the sub_category as #{i.sub_category_name}+++++++++"

         puts "+++++++++master_hash before fetch_products_list_id #{@master_hash}.."

          @master_hash[@sub_category_flag][:final] = Search.fetch_products_list_id(@filter_extended_params,@master_hash[@sub_category_flag][:final].flatten.map {|x| x},"mobiles_list_id","mobiles_lists")#This method is located in the Search model which is for the mysql sub_queries based on the extended_params.

          puts "+++++++++master_hash after fetch_products_list_id #{@master_hash}.."

      end

    end

    end

    loop_categories(@sub_category_flag)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count. Located in application_controller, FOR ONLY THE CURRENT Subcategory.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    render ('search/generic')

  end

  def suggestions

    set_query_as_nil# This will set the params[:query] as nil, since the user has clicked the suggestions links, it no more sensible to display the searched keyword in the search box

    self.create_instance_variables_for_suggestions# create the instance variables that are totally necessary for rendering the result of a click on any suggestions links.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

    @master_hash = FiltersCollections.filter_search(@master_hash,@filter_key,@sub_category_flag,@products_list_id_hash)# filter_search method is called from the FiltersCollections model, which is take sub_category_id and one filter_key and a products_list_id_hash which has the products_list_ids in part-1 as input and do a search on FiltersCollections table and return a master_hash

    form_master_hash_final# After populating :filter place of the master_hash the :final place has to be populated and this method does that. Located in application_controller.

    @matched_filter_keys = FiltersCollections.get_matched_filter_keys# this is a method in the model FiltersCollections to retrieve the words in the query which matched as a filter during FiltersCollections search.

    render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts, FOR ALL THE Subcategories.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

    render ('search/generic')

  end

  def cross_filters

    @view_name = params[:view_name]

    @page = set_page(params[:from_pagination].to_i,params[:page].to_i)

    if !(params[:filter_type].empty?)

      params_filter_type = params[:filter_type]

        if !(remove_tree_filter_id_from_params(params[params_filter_type.to_sym],params[:tree_filter_id]).empty?)

          params[params_filter_type.to_sym] = remove_tree_filter_id_from_params(params[params_filter_type.to_sym],params[:tree_filter_id])

        else

          params[params_filter_type.to_sym] = nil

        end

    end

    filters

  end

  def remove_tree_filter_id_from_params(params_filter_id,tree_filter_id)

    if !(params_filter_id.nil?)

      filters_array = params_filter_id.split("|")

      filters_array.delete_if{|i| i.split(">")[1] == tree_filter_id.to_s}.join("|")

    else

      []

    end

  end

#================ Direct Functions - END ================

  # functions defined after this section are auxillary
#================ Auxillary Functions - START ================


  def create_instance_variables_for_filters

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}# this is declared without being used anywhere because in the view _filters_results.html.erb, .empty? is used to check which needs this variable to be declared. Bad one.

    @sub_category_flag = params[:sub_category_id].to_i# Setting the @sub_category_flag which really important and this keeps the whole filtering process informed about the current sub_category_id.

    @view_name = params[:view_name]# @view_name is set.

  end

  def create_instance_variables_for_suggestions

    @hide_suggestions = 1

    @view_name = params[:view_name]

    @sub_category_flag = params[:sub_category_id].to_i

    @filter_key = params[:filter_key].to_s

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @products_list_id_hash = Hash.new{|hash, key| hash[key] = Array.new}

  end



#================ Auxillary Functions - END ================

end


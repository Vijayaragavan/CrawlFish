class CategoryController < ApplicationController

# functions defined after this section are direct
#================ Direct Functions - START ================

  def switch

    self.create_instance_variables# create the instance variables that are totally necessary for the switching the category.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    puts "View #{@view_name} ALREADY EXIST..."

    set_master_hash_from_generic_view# The master_hash which was created in the create_instance_variables method will be set from the generic_view based on the data present in the view_name procured from the url parameter as params[:view_name]

    puts "this is master hash after setting from generic_view #{@master_hash}"

    loop_categories(@sub_category_flag)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count. Located in application_controller, FOR ONLY THE CURRENT Subcategory.

    self.set_products_count_of_other_categories(@master_hash.keys - [@sub_category_flag])

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    render ('search/generic')

  end

#================ Direct Functions - END ================

  # functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def create_instance_variables

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}# this is declared without being used anywhere because in the view _filters_results.html.erb, .empty? is used to check which needs this variable to be declared. Bad one.

    @sub_category_flag = params[:sub_category_id].to_i# Setting the @sub_category_flag which really important and this keeps the whole filtering process informed about the current sub_category_id.

    @view_name = params[:view_name]# @view_name is set.

    @available_from_final = Hash.new

  end

  def set_products_count_of_other_categories(sub_category_ids_array)

    sub_category_ids_array.each do |i|

      set_products_count(i)

    end

  end

#================ Auxillary Functions - END ================


end


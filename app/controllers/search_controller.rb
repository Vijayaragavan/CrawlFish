class SearchController < ApplicationController

  include SearchModule

  # functions defined after this section are direct
#================ Direct Functions - START ================

  def index

    @raw_key  = params[:query]

    if validate_searchkey(@raw_key)

        #session[:user_key] = "currentuser"

        set_session_variables#In this, all the session variables are being set, mainly the session id is concatenated with "generic" which will be used for this sessions view name.

        session[:query] = @raw_key

        @view_name = session[:generic_view_name]

        set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

        #page params from pagination links is set.
        @page = params[:page]

        #If a view already exists with the same name, this method will drop it.
        Search.drop_temp_view(@view_name)

        self.make_search_key_unique#This method forms an array with the raw_key, so every individual word in the query will become the elements of that array. Now, picking up the unique elements in the array and using join to form a string as @literal_search_key.

        self.start_search#starts all the activities for a search.

    end

  end

  def start_search

    #preliminary_actions
    self.create_instance_variables# create the instance variables that are totally necessary for the search from home to generic.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    self.start_generic_search#find below the list of things done by this method.
    #1. set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.
    #2. Calls start_title_filter_searches, which will search the query in ProductsFilterCollections and FiltersCollections tables
    #3. Calls order_titles_filters which rank the results based on no of occurences for relevance.
    #4. Calls create_join which will populate the :join place of master_hash.
    #5. Calls form_master_hash_final, after ordering for relevance, this method populates the :final place of master_hash which will be displayed on the page.
    #6. Call get_key_of_max_value_count a method in ruby_utilities module to find the max number of categories
    #7. Calls render_categories_filters which is in application_controller responsible for forming the left side bar of the generic page, filters, categories and counts.
    #8. Check no_books_flag and no_mobiles_flag and render no results page or generic page.


  end

  #================ Direct Functions - END ================

#===============Rough Section START=======================


  def start_specific_search

    self.set_sub_category_and_product_ids(@master_hash)

    redirect_to specific_path(:specific_product_id => @product_id, :sub_category_id => @sub_category_id )

  end

  def set_sub_category_and_product_ids(master_hash)

    master_hash.keys.each do |i|

      if !(master_hash[i][:title].flatten.empty?)
        @product_id = master_hash[i][:title].flatten.join
        @sub_category_id = i
      end

    end

  end

#===============Rough Section END=======================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def create_instance_variables

    @no_results_flag = 0

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @products_list_id_hash = Hash.new{|hash, key| hash[key] = Array.new}

    @unmatched_title_keys = [ ]

    @exact_title_and_filter_flag = 0

    @available_from_final = Hash.new

  end

  def unarticle_search_key

    temp = @literal_search_key.split(" ")

    if temp.size > 1

    @unarticled_search_key = (temp - []).join(" ")

    else

    @unarticled_search_key = @literal_search_key

    end

    @unarticled_search_key

  end

  def remove_re_search_if_exact

        puts "this is matched_filter_keys..  #{FiltersCollections.get_matched_filter_keys}"

        matched_filter_keys = FiltersCollections.get_matched_filter_keys

        puts "this is literal_search_key before.. #{@literal_search_key}"

        @literal_search_key = (@literal_search_key.split(" ") - matched_filter_keys.values.flatten.uniq.join(" ").split(" ")).join(" ")

        puts "this is literal_search_key after.. #{@literal_search_key}"

  end

  def start_title_filter_searches

     puts "starting deep_search_plus..."
     puts "____________________________"

     @master_hash = ProductsFilterCollections.deep_search_plus(@master_hash,make_sphinx_search_key(@literal_search_key,"deep"),@sub_categories)#This will search for titles in the query against ProductsFilterCollections in plus mode. Plus mode is nothing but all the words in the document should be matched with one or more words in the query.

     puts @master_hash

     puts "____________________________"

     if !check_deep_search_plus(@master_hash,"title")#Located in search_module, this will check if there is atleast one result for the search, based on title.

             puts "starting deep_search_minus inside else condition of deep_search_plus..."
             puts "____________________________"

             @master_hash = ProductsFilterCollections.deep_search_minus(@master_hash,make_sphinx_search_key(@literal_search_key,"deep"),@sub_categories)#This will search for titles in the query against ProductsFilterCollections in minus mode. Minus mode is nothing but one or more words in the document should be matched with one or more words in the query.

             puts @master_hash

             puts "____________________________"

         puts "starting filters_search inside deep_search_plus..."
         puts "_______________________________"

         start_filter_search# Starting the search on FiltersCollections table.


         puts @master_hash

         puts "_______________________________"

     else

         @unmatched_title_keys = ProductsFilterCollections.get_unmatched_title_keys# this is a method in the model ProductsFilterCollections to retrieve the words in the query which didnt match as a title during ProductsFilterCollections.deep_search_plus.

         puts "Unmatched_title_keys is listed here..."

         puts @unmatched_title_keys

         puts "_______________________________"

         @exact_title_and_filter_flag = 1#This flag is set to 1, if there are results matched in ProductsFilterCollections.deep_search_plus

         start_filter_search# Starting the search on FiltersCollections table.

    end

  end

  def start_filter_search

    if @exact_title_and_filter_flag == 1#If there were results for ProductsFilterCollections.deep_search_plus, then we are going to remove the words which got a match in titles which is same as saying, retrieve the words which didnt get a match in titles and starting searching them in FiltersCollections table.

      @literal_search_key = @unmatched_title_keys

    end

    puts "starting surface_search on filters..."
    puts "____________________________"

    @hide_suggestions = 0# The suggestions links will not be hidden if this is set to 0, assuming not all the words of the query exactly matched as a fitler.

    puts "BEFORE IF-the value of filter_surface_search is #{@filter_surface_search}"

    @master_hash = FiltersCollections.surface_search(@master_hash,make_sphinx_search_key(@literal_search_key,"surface"),@products_list_id_hash)# A surface_search searches FiltersCollections and checks if all the words in the query exactly matches as a filter.

    puts @master_hash

    puts "____________________________"

    if !(check_specificity(@master_hash,"filter"))# If all the words of the query matched as a filter?, This method is called from search_module

      puts "IN IF-the value of filter_surface_search is #{@filter_surface_search}"

      puts "starting deep_search_plus on filters..."
      puts "____________________________"

        @master_hash = FiltersCollections.deep_search_plus(@master_hash,make_sphinx_search_key(@literal_search_key,"deep"),@products_list_id_hash)#this method is located in FiltersCollections model. Same as deep_search_plus in ProductsFilterCollections, only except this is for filters.

      self.remove_re_search_if_exact#This method will remove those words from the query which got exact matches in FiltersCollections and starts filters_search for the words that are left out.

      puts @master_hash

      puts "____________________________"

        if !(@literal_search_key.empty?)#If the above step gave residue words from the query even after executing remove_re_search_if_exact, the we will go inside if.


                 puts "starting filters_search inside else condition of deep_search_plus..."
                 puts "_______________________________"

                puts "starting deep_search_minus on filters..."
                puts "____________________________"

                @master_hash = FiltersCollections.deep_search_minus(@master_hash,make_sphinx_search_key(@literal_search_key,"deep"),@products_list_id_hash)# those residue words will be searched as filters in FiltersCollections

                puts @master_hash

                puts "____________________________"

        end
      else

        @hide_suggestions = 1# The suggestions links will be hidden since there was only one filter matched.

        puts "IN ELSE-the value of filter_surface_search is #{@filter_surface_search}"

    end

  end

  def start_generic_search


          puts "starting form_products_list_id_hash.."
          puts "_______________________________"

          form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

          puts @products_list_id_hash

          puts "_______________________________"

          self.start_title_filter_searches# starts search in ProductsFilterCollections and FiltersCollections tables.

          puts "starting order_titles_filters.."

          puts "_______________________________"

          self.order_titles_filters# Now that the master_hash is all set with results, it has to be ordered for relevance. This method does that.

          puts "_______________________________"

          puts "starting create_join.."

          puts "_______________________________"

          self.create_join#This will populate the :join place of the master_hash.

          puts @master_hash

          puts "_______________________________"

          puts "starting form_master_hash_final.."

          form_master_hash_final# After populating :filter,:title,:join places of the master_hash the :final place has to be populated and this method does that. Located in application_controller.

          puts @master_hash

          puts "_______________________________"


          puts "#######--the value of @order is #{@order}--##"

          render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts.

          @matched_filter_keys = FiltersCollections.get_matched_filter_keys# this is a method in the model FiltersCollections to retrieve the words in the query which matched as a filter during FiltersCollections search.

          set_category_order(1)# This method is called from application_controller, decides which category has to be listed first.


          puts "matched_filter_keys..."
          puts "_______________________________"

          puts @matched_filter_keys
           puts "_______________________________"

          if @no_books_flag == 1 && @no_mobiles_flag == 1# check whether there are results for books and mobiles.

             @message = "No results fetched!"

             render ('shared/no_results')

          else

            Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

            @final_search_key = @literal_search_key
		 
            render ('generic')

          end

  end

  def make_search_key_unique

    @literal_search_key =  @raw_key.split(" ").uniq.join(" ").downcase

  end

  def validate_searchkey(searchkey)

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

  def make_sphinx_search_key(search_key,type)

    search_key_unique = search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq

    search_key_string = search_key_unique.join(" ")

    if type == 'surface'

      search_key_size = search_key_unique.size

      sphinx_search_key =  "\"#{search_key_string}\"/#{search_key_size}"

    elsif type == 'deep'

      sphinx_search_key =  "\"#{search_key_string}\"/1"

    end

    sphinx_search_key

  end

  def order_titles_filters

    @master_hash.keys.each do |i|

      if !(@master_hash[i][:title].flatten.empty?)

        puts "--TITLE--testing @master_hash[:title] before order_products_id...#{@master_hash}.."

        @master_hash[i][:title] = order_products_id(@master_hash[i][:title].flatten)

        puts "............................"

        puts "--TITLE--testing @master_hash[:title] after order_products_id...#{@master_hash}.."



      end

      if !(@master_hash[i][:filter].flatten.empty?)

        if (@master_hash[i][:title].flatten.empty?)

            puts "..........................."

            puts "--FILTER--testing @master_hash[:filter] before order_products_id...#{@master_hash}.."

            @master_hash[i][:filter] = order_products_id(@master_hash[i][:filter])

            puts "..........................."

            puts "--FILTER--testing @master_hash[:filter] after order_products_id...#{@master_hash}.."

        end

      end

    end

  end

  def create_join


     @master_hash.keys.each do |sub_category_id|

       if !(@master_hash[sub_category_id][:title].flatten.empty?)  && !(@master_hash[sub_category_id][:filter].flatten.empty?)

         @master_hash[sub_category_id][:join] = order_products_id(@master_hash[sub_category_id][:title].flatten + @master_hash[sub_category_id][:filter].flatten)

       end

     end

   end

  def order_products_id(actual)

        actual.flatten.group_by{|x| x}.sort_by{|k, v| -v.size}.map(&:first)

  end

#================ Auxillary Functions - END ================

  def specific

  end

  def generic

  end

  def exception

  end

end


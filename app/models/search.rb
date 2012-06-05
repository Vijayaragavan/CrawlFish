class Search < ActiveRecord::Base

  attr_accessor :matched_filter_keys

  def self.create_generic_view(master_hash,generic_view_name)

    self.drop_temp_view(generic_view_name)

    id_hash = Hash.new{|hash, key| hash[key] = Array.new}

    @sub_categories = Subcategories.all

    master_hash.keys.each do |sub_category_id|

      if !(master_hash[sub_category_id][:final].flatten.empty?)

         id_hash[sub_category_id] << master_hash[sub_category_id][:final].flatten

       end

    end

    bridge = String.new

    id_hash.keys.each do |i|

      if !(id_hash[i].flatten.empty?)

        one_sql = " (SELECT distinct(products_list_id),sub_category_id FROM link_products_lists_vendors WHERE products_list_id IN "+"("+id_hash[i].flatten.join(",")+") AND sub_category_id = "+i.to_s+" ORDER BY FIELD ("+"products_list_id"+","+id_hash[i].flatten.join(",")+") LIMIT 10000000000000)"

        if bridge == " UNION "

          @sql = @sql+bridge+one_sql

        else

          @sql = one_sql


        end

      end

      bridge = " UNION "

   end

    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

    puts "these are ids #{id_hash}..end of ids"

    puts "this is generic_view_name..#{generic_view_name}..end.."

        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

    sql = "Create View "+generic_view_name+" AS "+@sql

    ActiveRecord::Base.connection.execute(sql)

  end

  def self.create_filter_view(id_array,view_name)

    self.drop_temp_view(view_name)

    ids = id_array.flatten.join(",")

    sql = "Create View "+view_name+" AS SELECT distinct(products_list_id),sub_category_id FROM link_products_lists_vendors WHERE products_list_id IN"+"("+ids+")"

    ActiveRecord::Base.connection.execute(sql)

  end



  def self.get_products_list_id(view_name,sub_category_id)

    sql = ActiveRecord::Base.connection()
    stmt= "SELECT products_list_id FROM "+view_name+" WHERE sub_category_id = "+sub_category_id.to_s
    sql.select_values(stmt)

  end

  def self.drop_temp_view(view_name)

    if !(view_name.nil?)
      sql = "DROP VIEW IF EXISTS "+view_name
      ActiveRecord::Base.connection.execute(sql)
    end

  end

  def self.check_view_existence(view_name)

    db_name = ActiveRecord::Base.connection.current_database

    sql = "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = "+"'"+view_name+"'"+" AND table_schema = "+"'"+db_name+"'"

    (ActiveRecord::Base.connection.execute(sql).map &:first).join

  end

  def self.fetch_products_list_id(extended_params,products_list_id,column_name,table_name)

    products_list_ids_array = [ ]

    if (extended_params.empty?)

     if table_name == "books_lists"

       products_list_ids_array << BooksList.where(column_name+" IN (?)",products_list_id).select(column_name).order("FIELD ("+column_name+","+products_list_id.join(",")+")").map{|i| i.send(column_name) }

     elsif table_name == "mobiles_lists"

       products_list_ids_array << MobilesLists.where(column_name+" IN (?)",products_list_id).select(column_name).order("FIELD ("+column_name+","+products_list_id.join(",")+")").map{|i| i.send(column_name) }

     end

     products_list_ids_array

    else

    products_list_ids_array << connection.select_values(construct_query(extended_params,products_list_id,column_name,table_name))

    products_list_ids_array

    end

  end

    def self.construct_query(sortedFinal,products_list_ids_array,products_list_id,table_name)
      sql = String.new
      sortedFinal.each do |detail|

        head = "SELECT "+products_list_id.to_s+" FROM "+detail[:link_table_name].to_s+" WHERE "+products_list_id.to_s+" IN ("
        tail = ") AND "+detail[:filter_id].to_s+" = "+detail[:id].to_s
        if sql.empty?
          firstSql = "SELECT "+products_list_id.to_s+" FROM "+detail[:link_table_name].to_s+" WHERE "+products_list_id.to_s+" IN ("+products_list_ids_array.join(",")+") AND "+detail[:filter_id].to_s+" ="+detail[:id].to_s
          sql = firstSql
        else
          sql = head+sql+tail
        end
      end

      if sql.empty?

        sql =

        "SELECT "+products_list_id.to_s+" FROM "+table_name.to_s+" WHERE "+products_list_id.to_s+" IN ("+products_list_ids_array.join(",")+") ORDER BY FIELD ("+products_list_ids_array.join(",")+")"

      end

      return sql

    end

    def filters_deep_search(hash_key,v_hand_saw_hash,v_master_hash,v_products_list_id_hash,step = 0)

      @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

       @filter_details = []

      collect_filter_details(hash_key,v_hand_saw_hash,v_master_hash,step)

      fetch_filter_details(v_products_list_id_hash)

      rank_titles_filters

      create_join

        return @master_hash

    end

    def collect_filter_details(hash_key,v_hand_saw_hash,v_master_hash,step)

    flag = 0
    current_array_key = 0

    if step == 1
      @master_hash = v_master_hash
    end

    if !(hash_key == 0)

      hash_key.downto(1) { |hash_key|

        (0).upto(hash_key-1) { |arraykey|

            first_letter = v_hand_saw_hash[hash_key][arraykey][0]

            current_hash_value = v_hand_saw_hash[hash_key][arraykey]

            begin

               if find_filter_details(first_letter,current_hash_value)

                 current_array_key = arraykey
                 flag = 1

                 break

               end

            rescue SyntaxError, NameError

            end

         }

       if (flag == 1)

         collect_filter_details(current_array_key,v_hand_saw_hash,{},2)

         break

       end

        }

     end

   end

    def find_filter_details(first_letter,v1_current_hash_value)

    if first_letter == '0'
      modelname = "Zero"+"FiltersCollections"
    elsif first_letter == '1'
      modelname = "One"+"FiltersCollections"
    elsif first_letter == '2'
      modelname = "Two"+"FiltersCollections"
    elsif first_letter == '3'
      modelname = "Three"+"FiltersCollections"
    elsif first_letter == '4'
      modelname = "Four"+"FiltersCollections"
    elsif first_letter == '5'
      modelname = "Five"+"FiltersCollections"
    elsif first_letter == '6'
      modelname = "Six"+"FiltersCollections"
    elsif first_letter == '7'
      modelname = "Seven"+"FiltersCollections"
    elsif first_letter == '8'
      modelname = "Eight"+"FiltersCollections"
    elsif first_letter == '9'
      modelname = "Nine"+"FiltersCollections"
    else
      modelname = first_letter.upcase+"FiltersCollections"
    end

    current_filter_detail = [ ]

    current_filter_detail << modelname.constantize.where("filter_key LIKE (?) ", "#{v1_current_hash_value}%").select("filter_id,filter_table_name,filter_table_column,sub_category_id")

     if !(current_filter_detail.flatten.blank?)
       @filter_details << current_filter_detail.flatten
       @matched_filter_keys[current_filter_detail.flatten.last.sub_category_id] << v1_current_hash_value
       return true

    else current_filter_detail.flatten.blank?

      return false

    end

  end

  def set_m(m)

    @m = m

  end


  def fetch_filter_details(v_products_list_id_hash)

    id = [ ]
    table_name = [ ]
    column_name = [ ]
    sub_category_id = [ ]

    for i in (0..@filter_details.flatten.length-1)
        id << @filter_details.flatten[i].filter_id
        table_name << @filter_details.flatten[i].filter_table_name
        column_name << @filter_details.flatten[i].filter_table_column
        sub_category_id << @filter_details.flatten[i].sub_category_id

        #==The books_list_id and mobiles_list_id has to be retrieved from the database filter_collectiosn tables
        if sub_category_id[i] == 1
          product_id = "books_list_id"
        elsif sub_category_id[i] == 2
          product_id = "mobiles_list_id"
        end

        conditions = [[]]

        conditions[0] << column_name[i]
        conditions[0] << ' IN  ('
        conditions[0] << id[i]
        conditions[0] << ')'
        conditions[0] << ' AND '
        conditions[0] << product_id
        conditions[0] << ' IN  ('
        conditions[0] << v_products_list_id_hash[sub_category_id[i]].join(",")
        conditions[0] << ')'
        conditions[0] = conditions[0].join

        @master_hash[sub_category_id[i]][:filter] << table_name[i].constantize.where(conditions[0]).select(product_id).map {|x| x.send(product_id)}

    end

  end

  def rank_titles_filters

    @master_hash.keys.each do |i|

      if !(@master_hash[i][:title].flatten.empty?)

        @master_hash[i][:title] = self.rank_products_id(@master_hash[i][:title].flatten)

      end

      if !(@master_hash[i][:filter].flatten.empty?)

        @master_hash[i][:filter] = self.rank_products_id(@master_hash[i][:filter].flatten)

     end

    end
  end


   def rank_products_id(filters_products_id)

    temp_array = [ ]

      begin


        count_hash = filters_products_id.flatten(1).inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        #************************== Highly Reusable==************************************
        #(count_hash.values.max).downto(1)  { |i|
	        # temp_array << count_hash.select {|k,v| v == i}.keys
	      #}
	      #*********************************************************************************

	      temp_array = count_hash.select {|k,v| v == count_hash.values.max}.keys

        return temp_array

      rescue SyntaxError, NoMethodError

        return

      end
   end

   def create_join

     @master_hash.keys.each do |sub_category_id|

       @master_hash[sub_category_id][:join] = @master_hash[sub_category_id][:title] & @master_hash[sub_category_id][:filter]

     end

   end

   def get_matched_filter_keys

    return @matched_filter_keys
  end

end


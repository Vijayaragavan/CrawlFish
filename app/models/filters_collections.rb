class FiltersCollections  < ActiveRecord::Base

  define_index do

    indexes filter_key

    has filter_id

    has sub_category_id

    has "f_remove_stopwords(filter_key)", :as => :word_count, :type => :integer

  end

  attr_accessor :matched_filter_keys

  @@matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

  def self.filter_search(master_hash,filter_key,sub_category_id,products_list_id_hash)

    filter_details = []

    with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    filter_details = (search(filter_key,:match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => { 'filter' => 1, :sub_category_id => sub_category_id  }))

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end


  def self.surface_search(master_hash,sphinx_search_key,products_list_id_hash)

    with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    filter_details =  (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1})

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end

  def self.deep_search_plus(master_hash,sphinx_search_key,products_list_id_hash)

    with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    filter_details =  (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1})

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end

  def self.deep_search_minus(master_hash,sphinx_search_key,products_list_id_hash)

    filter_details = []

    filter_details = (search  sphinx_search_key, :match_mode => :extended, :star => true)

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end

  def self.insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

    filter_details.each do |i|

         conditions = [ ]

         products_list_id = Subcategories.what_is_my_name(i.sub_category_id).join[0..-2] + "_id"

         if i.filter_id == 0

              conditions << products_list_id
              conditions << ' IN  ('
              conditions << products_list_id_hash[i.sub_category_id].join(",")
              conditions << ')'
              conditions = conditions.join

              master_hash = self.fetch_filter_details(master_hash,conditions,products_list_id,i.sub_category_id,i.filter_key,i.filter_table_name)


         else

              conditions << i.filter_table_column
              conditions << ' IN  ('
              conditions << i.filter_id
              conditions << ')'
              conditions << ' AND '
              conditions << products_list_id
              conditions << ' IN  ('
              conditions << products_list_id_hash[i.sub_category_id].join(",")
              conditions << ')'
              conditions = conditions.join

              master_hash = self.fetch_filter_details(master_hash,conditions,products_list_id,i.sub_category_id,i.filter_key,i.filter_table_name)

         end

    end

    master_hash

  end

  def self.get_matched_filter_keys

    @@matched_filter_keys

  end

  def self.fetch_filter_details(master_hash,conditions,products_list_id,sub_category_id,filter_key,filter_table_name)

        @@matched_filter_keys[sub_category_id] <<  filter_key

        current_products_list_id = filter_table_name.constantize.where(conditions).select(products_list_id).map {|x| x.send(products_list_id)}

        if !(current_products_list_id.flatten.empty?)

          master_hash[sub_category_id][:filter]  << current_products_list_id

        end

        master_hash

  end

end


class ProductsFilterCollections < ActiveRecord::Base

  include SearchModule

  define_index do

    indexes filter_key

    has sub_category_id

    has "f_remove_stopwords(filter_key)", :as => :word_count, :type => :integer



  end

  attr_accessor :matched_title_keys

  @@unmatched_title_keys =  Array.new

  def self.surface_search(master_hash,sphinx_search_key,sub_categories)

    with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    sub_categories.each do |i|

      master_hash[i.sub_category_id][:title] =  (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1, :sub_category_id => i.sub_category_id }).map &:filter_id

      #sphinx_results =  master_hash[i.sub_category_id][:title]

      #sphinx_results[:words].keys.each do |j|

        #if sphinx_results[:words][j][:hits] >= 1

         # @@matched_title_keys[i.sub_category_id] << j

        #end

      #end

    end

    master_hash

  end

  def self.deep_search_plus(master_hash,sphinx_search_key,sub_categories)

    with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    sub_categories.each do |i|

      @result_set =  (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1, :sub_category_id => i.sub_category_id })

      master_hash[i.sub_category_id][:title] = @result_set.map &:filter_id

    end

    sphinx_results = @result_set.results

      sphinx_results[:words].keys.each do |word|

        if sphinx_results[:words][word][:hits] == 0

          @@unmatched_title_keys << word

        end

      end

    master_hash

  end

  def self.deep_search_minus(master_hash,sphinx_search_key,sub_categories)

    sub_categories.each do |i|

      master_hash[i.sub_category_id][:title] =  (search  sphinx_search_key, :match_mode => :extended, :with => {:sub_category_id => i.sub_category_id }).map &:filter_id

    end

    master_hash

  end

  def self.get_unmatched_title_keys

    @@unmatched_title_keys.join(" ")

  end

end


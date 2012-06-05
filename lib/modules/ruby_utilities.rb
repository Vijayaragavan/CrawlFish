module RubyUtilities


  def get_key_of_max_value_count(hash)

    count_hash = Hash.new

    hash.keys.sort.each do |sub_category_id|

          count_hash[sub_category_id] = 0

          if !(hash[sub_category_id][:join].flatten.empty?)

            count_hash[sub_category_id] = count_hash[sub_category_id] + hash[sub_category_id][:join].flatten.size

          elsif !(hash[sub_category_id][:title].flatten.empty?)

            count_hash[sub_category_id] = count_hash[sub_category_id] + hash[sub_category_id][:title].flatten.size

        elsif !(hash[sub_category_id][:filter].flatten.empty?)

            count_hash[sub_category_id] = count_hash[sub_category_id] + hash[sub_category_id][:filter].flatten.size

          else

            count_hash[sub_category_id] = count_hash[sub_category_id] + 0

          end


    end

  count_hash.sort_by{|k,v| v}.reverse.map {|k,v| k}


           ##== This code can be reused, if you have an hash of arrays
           ##and if you want find out which key has the maximum number of values
           ##==start
           #hash.map { |k,v| if (v.nil?)
           #p k ,0 ;
           #elsif (v[0].nil?)
           #p k, 0;
           #else p k , v[0].length end }.sort_by {|k,v| v}.reverse.map {|k,v| k}
           ##==end

  end


end


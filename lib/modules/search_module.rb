module SearchModule


  def first_index(hi)
   return "returned"
   @mango = "mango"
  end

  def get_size(search_key)

    search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze.split.size

  end

  def check_specificity(master_hash, type)

    if type == "title"

   master_hash.keys.each do |i|

      if !(master_hash[i][type.to_sym].flatten.empty?)

        if master_hash[i][type.to_sym].flatten.size == 1

          return true

        end
      end
    end

    return false

    elsif type == "filter"

      master_hash.keys.each do |i|

        if !(master_hash[i][type.to_sym].flatten.empty?)

            return true
        end

      end

    return false

    end

  end

  def check_deep_search_plus(master_hash,type)

    master_hash.keys.each do |i|

      if !(master_hash[i][type.to_sym].flatten.empty?)

          return true
      end

    end

    return false

  end



end


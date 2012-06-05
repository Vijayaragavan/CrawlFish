class Test < ActiveRecord::Base

   def self.filter_books(bookslistid,filters)

    unordered_final = [ ]
    sorted_final = [ ]
    step_books_list_id = [ ]



    if !(filters[:genre_id].nil?)

      unordered_final << form_unordered_final("genre_id","link_f2_books_lists",filters)

    end

    if !(filters[:binding_id].nil?)

      unordered_final << form_unordered_final("binding_id","link_f5_books_lists",filters)

    end

    if !(filters[:language_id].nil?)

       unordered_final << form_unordered_final("language_id","link_f9_books_lists",filters)

    end

    if !(filters[:publisher_id].nil?)

       unordered_final << form_unordered_final("publisher_id","link_f7_books_lists",filters)


    end

    sorted_final = unordered_final.flatten.sort_by {|i| i[:order]}
    step_books_list_id << connection.select_values(construct_query(sorted_final,bookslistid,"books_list_id"))

    return step_books_list_id

  end

  def self.filter_mobiles(mobileslistid,filters)
    unordered_final = [ ]
    sorted_final = [ ]
    step_mobiles_list_id = [ ]



    if !(filters[:mobile_brand_id].nil?)

      unordered_final << form_unordered_final("mobile_brand_id","link_f1_mobiles_lists",filters)


    end

    if !(filters[:mobile_color_id].nil?)

      unordered_final << form_unordered_final("mobile_color_id","link_f2_mobiles_lists",filters)

    end

    if !(filters[:mobile_type_id].nil?)

      unordered_final << form_unordered_final("mobile_type_id","link_f3_mobiles_lists",filters)

    end

    if !(filters[:mobile_design_id].nil?)

      unordered_final << form_unordered_final("mobile_design_id","link_f4_mobiles_lists",filters)

    end

    if !(filters[:mobile_os_id].nil?)

      unordered_final << form_unordered_final("mobile_os_id","link_f5_mobiles_lists",filters)

    end

    if !(filters[:primary_camera_id].nil?)

      unordered_final << form_unordered_final("primary_camera_id","link_f9_mobiles_lists",filters)

    end

    if !(filters[:secondary_camera_id].nil?)

      unordered_final << form_unordered_final("secondary_camera_id","link_f10_mobiles_lists",filters)

    end

    if !(filters[:assorteds_id].nil?)

      unordered_final << form_unordered_final("assorteds_id","link_f15_mobiles_lists",filters)

    end

    sorted_final = unordered_final.flatten.sort_by {|i| i[:order]}
    step_mobiles_list_id << connection.select_values(construct_query(sorted_final,mobileslistid,"mobiles_list_id"))

    return step_mobiles_list_id

  end

  def self.form_unordered_final(filter_id,link_table_name,filters)

      step_mobiles_list_id = [ ]
      filter_column_name = filter_id
      append_zero=filters[filter_id.to_sym]
      filter_id = append_zero.split("|")
      return remove_duplicate_id(filter_id,filter_column_name,link_table_name)

  end


    def self.remove_duplicate_id(idArray,filterColumnName,linkTableName)
      quarterFinal = [ ]
      semiFinal = [ ]
      idArray.each do |i|
        ar = []
        z={}
        ar = i.split(">")
        #z[:order]= ar[0]
        z[:order]=ar[0]
        z[:id] = ar[1]
        z[:filterColumn]=filterColumnName
        z[:linkTable]=linkTableName

        quarterFinal << z

      end

      semiFinal = quarterFinal.uniq  {|e| e[:id] }

      return semiFinal

end
end


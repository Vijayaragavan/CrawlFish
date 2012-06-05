require "fileutils"
class General < ActiveRecord::Base

  def self.get_lowest_price(product_ids,sub_category_id,exclude_availabilities_array)

    product_ids_string = product_ids.join(",")
    sub_category_id_string = sub_category_id.to_s
    exclude_availabilities_array_string = exclude_availabilities_array.join(",")

        sql = "SELECT products_list_id,min(lowest_price) FROM ((SELECT products_list_id , min(`local_grid_details`.`price`) AS lowest_price FROM `local_grid_details` INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = local_grid_details.unique_id WHERE (link_products_lists_vendors.products_list_id IN (" + product_ids_string+") AND link_products_lists_vendors.sub_category_id = "+sub_category_id_string +" AND link_products_lists_vendors.availability_id not in ("+exclude_availabilities_array_string+")) group by link_products_lists_vendors.products_list_id)

    UNION

    (SELECT products_list_id , min(`online_grid_details`.`price`) AS lowest_price FROM `online_grid_details` INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id = online_grid_details.unique_id WHERE (link_products_lists_vendors.products_list_id IN (" + product_ids_string+") AND link_products_lists_vendors.sub_category_id = "+sub_category_id_string+" AND link_products_lists_vendors.availability_id not in ("+exclude_availabilities_array_string+"))
    group by link_products_lists_vendors.products_list_id)) AS local_online group by products_list_id"

    connection.execute(sql)

  end

  def self.get_unique_id_between_given_price(price)

    sql = "(SELECT unique_id
            FROM online_grid_details
            WHERE price
            BETWEEN #{price-1000} AND #{price+1000})
            UNION
            (SELECT unique_id
            FROM local_grid_details
            WHERE price
            BETWEEN #{price-1000} AND #{price+1000})"

     connection.execute(sql).map{|i|  i}.flatten

  end

  def self.split_search_key(searchkey)

    keys = searchkey.gsub(/\-/i, ",").gsub(/ /i,",").gsub(/\+/,",").split(",").map(&:strip).reject(&:empty?)

    return keys

  end

  def self.remove_articles_from_search_key(keys)

    unarticled_keys = keys - ["a","the","an"]

    return unarticled_keys

  end

   def self.get_filter_id_name_count(product_ids,filter_id,filter_name,filter_table_name,products_list_id,link_table_name)

     sql = "SELECT one."+filter_id+" as filter_id,
                 one."+filter_name+" as filter_name,
                 two.count as count
              FROM   "+filter_table_name+" one
                     INNER JOIN (SELECT "+filter_id+" ,
                                 count(*) as count
                                 FROM "+link_table_name+"
                                 WHERE "+products_list_id+" IN ("+product_ids.join(",")+")
                                 GROUP BY "+filter_id+") two
              WHERE one."+filter_id+" = two."+filter_id

     case filter_id

     when "genre_id" then

       sql = sql + " AND one.level_id = 1"

     end

     sql = sql + " ORDER BY filter_name"

     connection.execute(sql.gsub(/\n/,"").squeeze(' '))

  end

  ## this method will be deprecated in the next version

  def self.get_filter_names(filter_ids,filter_type,filter_name,filter_name_id,index,product_sub_category,genre_option = 0)

    modelname=product_sub_category.camelize+"F"+index.to_s+filter_type.camelize

    case filter_type

      when "genre" then
        modelname.constantize.where(filter_name_id+" IN (?) AND level_id = 1", filter_ids.map { |v| v } ).order(filter_name)
    when "operating_systems" then
         modelname.constantize.where(filter_name_id+" IN (?)", filter_ids.map { |v| v } ).order("mobile_os_version,mobile_os_version")
       else
         modelname.constantize.where(filter_name_id+" IN (?)", filter_ids.map { |v| v } ).order(filter_name)
    end

  end


  def self.data_file_upload(upload,vendor_table_name)

    file_name =  upload['datafile'].original_filename

    directory_name = 'public/merchants_data/'+vendor_table_name

        if !(File.directory? directory_name)

          directory_name = FileUtils.mkdir directory_name, :mode => 0700

          directory_name = directory_name.join

        end
    # create the file path
    path = File.join(directory_name, file_name)
    # write the file
    size = File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    [file_name,size,path]

  end


end


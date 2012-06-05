class VendorProductTransactionsLogs < ActiveRecord::Base

  def self.get_total_count(vendor_id,parameter,sub_category_id = 0)

    if sub_category_id == 0

        where(:vendor_id => vendor_id).sum(parameter)

    else

        where(:vendor_id => vendor_id, :sub_category_id => sub_category_id).sum(parameter)

    end

  end

  def self.get_range(parameter,vendor_id,from_date,to_date,sub_category_id = 0)

      if sub_category_id == 0

        where(['vendor_id = ? AND log_date BETWEEN ? AND ?',vendor_id,from_date,to_date]).sum(parameter)

      else

        where(['vendor_id = ? AND sub_category_id = ? AND log_date BETWEEN ? AND ?',vendor_id,sub_category_id,from_date,to_date]).sum(parameter)

      end

  end

  def self.get_fixed_product_listing(vendor_id,sub_category_id = 0)

    sub_category_array = Array.new

    sub_category_array =  [["books_lists","p.book_name","p.isbn","p.books_list_id",1],["mobiles_lists","p.mobile_name","p.mobile_color","p.mobiles_list_id",2]]

    results = []

    if sub_category_id == 0

          sub_category_array.each do |i|

            results <<    joins("INNER JOIN #{i[0]} p").where("vendor_product_transactions_logs.vendor_id = ?
                            AND #{i[3]}= vendor_product_transactions_logs.product_id
                            AND vendor_product_transactions_logs.sub_category_id = ?",vendor_id,i[4]).group("vendor_product_transactions_logs.product_id,vendor_product_transactions_logs.sub_category_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
                            SUM(vendor_product_transactions_logs.page_impressions_count) as impression_count,
                            SUM(vendor_product_transactions_logs.button_clicks_count) as click_count")

           end

     else

           sub_category_array.each do |i|

                if sub_category_id == i[4]

                    results =   joins("INNER JOIN #{i[0]} p").where("vendor_product_transactions_logs.vendor_id = ?
                            AND #{i[3]} = vendor_product_transactions_logs.product_id
                            AND vendor_product_transactions_logs.sub_category_id = ?",vendor_id,i[4]).group("vendor_product_transactions_logs.product_id,vendor_product_transactions_logs.sub_category_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
                            SUM(vendor_product_transactions_logs.page_impressions_count) as impression_count,
                            SUM(vendor_product_transactions_logs.button_clicks_count) as click_count")

                 end

             end
      end

      results.flatten

  end

  def self.get_most_recognized_impressions(vendor_id)

    if vendor_id

      result = joins("INNER JOIN subcategories ON subcategories.sub_category_id = vendor_product_transactions_logs.sub_category_id").where(:vendor_id => vendor_id).group("vendor_product_transactions_logs.sub_category_id").order("impressions_count DESC ").limit("0,1").select("subcategories.category_name,vendor_product_transactions_logs.sub_category_id,SUM(vendor_product_transactions_logs.page_impressions_count) as impressions_count").map &:category_name

     if !(result.empty?)

       result

     else

       1

     end


    else

      puts "Invalid vendor_id!"

    end


  end

  def self.get_most_recognized_clicks(vendor_id)

    if vendor_id

     result =  joins("INNER JOIN subcategories ON subcategories.sub_category_id = vendor_product_transactions_logs.sub_category_id").where(:vendor_id => vendor_id).group("vendor_product_transactions_logs.sub_category_id").order("clicks_count DESC ").limit("0,1").select("subcategories.category_name,vendor_product_transactions_logs.sub_category_id,SUM(vendor_product_transactions_logs.button_clicks_count) as clicks_count").map &:category_name

     if !(result.empty?)

       result

     else

       1

     end

    else

      puts "Invalid vendor_id!"

    end

  end


  def self.get_variable_product_listing(vendor_id,sub_category_id = 0)

    sub_category_array = Array.new

    sub_category_array =  [["books_lists","p.book_name","p.isbn","p.books_list_id",1],["mobiles_lists","p.mobile_name","p.mobile_color","p.mobiles_list_id",2]]

    results = []

    if sub_category_id == 0

          sub_category_array.each do |i|

             results <<  joins("INNER JOIN
            variable_pay_vendors accepted
            ON  vendor_product_transactions_logs.vendor_id = accepted.vendor_id
            INNER JOIN
            #{i[0]} p
            ON #{i[3]} = vendor_product_transactions_logs.product_id").where("vendor_product_transactions_logs.vendor_id = ? AND vendor_product_transactions_logs.sub_category_id = ? ",vendor_id,i[4]).group("vendor_product_transactions_logs.sub_category_id,vendor_product_transactions_logs.product_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
            vendor_product_transactions_logs.page_impressions_count as impressions_count,
            (vendor_product_transactions_logs.page_impressions_count * accepted.accepted_impressions_rate) as total_impressions,
            vendor_product_transactions_logs.button_clicks_count as clicks_count,
            (vendor_product_transactions_logs.button_clicks_count * accepted.accepted_button_click_rate) as total_clicks")

          end



    else

      sub_category_array.each do |i|

        if sub_category_id == i[4]

            results = joins("INNER JOIN
            variable_pay_vendors accepted
            ON  vendor_product_transactions_logs.vendor_id = accepted.vendor_id
            INNER JOIN
            #{i[0]} p
            ON #{i[3]} = vendor_product_transactions_logs.product_id").where("vendor_product_transactions_logs.vendor_id = ? AND vendor_product_transactions_logs.sub_category_id = ? ",vendor_id,i[4]).group("vendor_product_transactions_logs.sub_category_id,vendor_product_transactions_logs.product_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
            vendor_product_transactions_logs.page_impressions_count as impressions_count,
            (vendor_product_transactions_logs.page_impressions_count * accepted.accepted_impressions_rate) as total_impressions,
            vendor_product_transactions_logs.button_clicks_count as clicks_count,
            (vendor_product_transactions_logs.button_clicks_count * accepted.accepted_button_click_rate) as total_clicks")

          end

        end

    end

    results.flatten

  end

  def self.get_impressions_clicks_product_listing(vendor_id,sub_category_id = 0)

    sub_category_array = Array.new

    sub_category_array =  [["books_lists","p.book_name","p.isbn","p.books_list_id",1],["mobiles_lists","p.mobile_name","p.mobile_color","p.mobiles_list_id",2]]

    results = []

    if sub_category_id == 0

          sub_category_array.each do |i|

             results <<  joins("INNER JOIN
            #{i[0]} p
            ON #{i[3]} = vendor_product_transactions_logs.product_id").where("vendor_product_transactions_logs.vendor_id = ? AND vendor_product_transactions_logs.sub_category_id = ? ",vendor_id,i[4]).group("vendor_product_transactions_logs.sub_category_id,vendor_product_transactions_logs.product_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
            vendor_product_transactions_logs.page_impressions_count as impressions_count,
                        vendor_product_transactions_logs.button_clicks_count as clicks_count")

          end



    else

      sub_category_array.each do |i|

        if sub_category_id == i[4]

            results = joins("INNER JOIN
            #{i[0]} p
            ON #{i[3]} = vendor_product_transactions_logs.product_id").where("vendor_product_transactions_logs.vendor_id = ? AND vendor_product_transactions_logs.sub_category_id = ? ",vendor_id,i[4]).group("vendor_product_transactions_logs.sub_category_id,vendor_product_transactions_logs.product_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
            vendor_product_transactions_logs.page_impressions_count as impressions_count,
                        vendor_product_transactions_logs.button_clicks_count as clicks_count")

          end

        end

    end

    results.flatten

  end




end


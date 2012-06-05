class VendorProductPurchasesLogs < ActiveRecord::Base

  def self.get_purchase_product_listing(vendor_id,sub_category_id = 0)

     sub_category_array = Array.new

    sub_category_array =  [["books_lists","p.book_name","p.isbn","p.books_list_id",1],["mobiles_lists","p.mobile_name","p.mobile_color","p.mobiles_list_id",2]]

    results = []

    if sub_category_id == 0

          sub_category_array.each do |i|

            results <<    joins("INNER JOIN #{i[0]} p").where("vendor_product_purchases_logs.vendor_id = ?
                            AND #{i[3]} = vendor_product_purchases_logs.product_id
                            AND vendor_product_purchases_logs.sub_category_id = ?",vendor_id,i[4]).group("vendor_product_purchases_logs.product_id,vendor_product_purchases_logs.sub_category_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
                            SUM(vendor_product_purchases_logs.product_purchase_count) as purchase_count,
                            vendor_product_purchases_logs.product_purchase_amount as purchase_amount")

           end

     else

           sub_category_array.each do |i|

                if sub_category_id == i[4]

                    results =  joins("INNER JOIN #{i[0]} p").where("vendor_product_purchases_logs.vendor_id = ?
                            AND #{i[3]} = vendor_product_purchases_logs.product_id
                            AND vendor_product_purchases_logs.sub_category_id = ?",vendor_id,i[4]).group("vendor_product_purchases_logs.product_id,vendor_product_purchases_logs.sub_category_id").select("CONCAT(#{i[1]},'(',#{i[2]},')') as product_name,
                            SUM(vendor_product_purchases_logs.product_purchase_count) as purchase_count,
                            vendor_product_purchases_logs.product_purchase_amount as purchase_amount")

                 end

             end
      end

      results.flatten

  end


end


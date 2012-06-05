class MonetizationPurchase < ActiveRecord::Base

  def self.get_sub_category_id_commission(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT v.sub_category_id as sub_category_id,p.product_purchase_commissions as commission
                 FROM product_purchase_commissions p
                 INNER JOIN
                 vendors_product_purchase_commissions v
                 WHERE  v.history_flag = 0
                 AND v.commission_id = p.pp_commission_id
                 AND v.vendor_id = "+vendor_id.to_s

     sub_category_id_commission = con.select_all(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     sub_category_id_commission


  end

   def self.get_cut_off_period(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT cut_off_period
                 FROM cut_off_periods
                 WHERE cut_off_period_id = (SELECT
                                            cut_off_period_id
                                            FROM vendors_product_purchase_commissions
                                            WHERE  history_flag= 0
                                            AND vendor_id = "+vendor_id.to_s+" LIMIT 1)"

     cut_off_period = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     cut_off_period

  end

   def self.get_purchase_commission_logs(vendor_id,product_sub_category_id,specific_sub_category_id = 0)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

    purchase_commission_log = [ ]

    if specific_sub_category_id == 0

      product_sub_category_id.each do |j|

        i = j.split(",")

        sql =  "SELECT vendor_id,
                       product_id,
                       sub_category_id,
                       sum(total_pp_comm_amount) as
                       commission_amount
                FROM product_purchase_commission_logs
                WHERE vendor_id = "+vendor_id.to_s+"
                AND product_id = "+i[0].to_s+"
                AND sub_category_id = "+i[1].to_s+"
                GROUP BY product_id,
                         sub_category_id"

        purchase_commission_log << con.execute(sql)

      end


    end

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     purchase_commission_log

  end


end


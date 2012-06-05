class MonetizationVariable < ActiveRecord::Base

  def self.get_accepted_impressions_rate(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT impression_rates
                 FROM impression_rates
                 WHERE i_rate_id = (SELECT i_rate_id
                                    FROM vendors_variable_pays
                                    WHERE history_flag = 0
                                    AND vendor_id = "+vendor_id.to_s+")"

     impression_rate = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     impression_rate

  end

  def self.get_accepted_button_clicks_rate(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT button_click_rates
                 FROM button_click_rates
                 WHERE bc_rate_id = (SELECT bc_rate_id
                                    FROM vendors_variable_pays
                                    WHERE history_flag = 0
                                    AND vendor_id = "+vendor_id.to_s+")"

     button_click_rate = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     button_click_rate

  end

  def self.get_cut_off_period(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT cut_off_period
                 FROM cut_off_periods
                 WHERE cut_off_period_id = (SELECT
                                            cut_off_period_id
                                            FROM vendors_variable_pays
                                            WHERE  history_flag= 0
                                            AND vendor_id = "+vendor_id.to_s+")"

     cut_off_period = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     cut_off_period

  end

  def self.get_cut_off_amount(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT cut_off_amount
                 FROM cut_off_amounts
                 WHERE cut_off_amount_id = (SELECT
                                            cut_off_amount_id
                                            FROM vendors_variable_pays
                                            WHERE  history_flag= 0
                                            AND vendor_id = "+vendor_id.to_s+")"

     cut_off_amount= con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     cut_off_amount

  end

  def self.get_variable_pay_logs(vendor_id,product_sub_category_id,specific_sub_category_id = 0)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

    variable_pay_log = [ ]

    if specific_sub_category_id == 0

      product_sub_category_id.each do |j|

        i = j.split(",")

        sql =  "SELECT vendor_id,
                       product_id,
                       sub_category_id,
                       sum(total_impressions_amount) as
                       impression_amount,
                       sum(total_button_clicks_amount) as
                       click_amount
                FROM variable_pay_logs
                WHERE vendor_id = "+vendor_id.to_s+"
                AND product_id = "+i[0].to_s+"
                AND sub_category_id = "+i[1].to_s+"
                GROUP BY product_id,
                         sub_category_id"

        variable_pay_log << con.execute(sql)

      end


    end

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     variable_pay_log

  end


end


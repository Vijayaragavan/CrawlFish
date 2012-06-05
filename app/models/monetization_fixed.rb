class MonetizationFixed < ActiveRecord::Base

  def self.get_fixed_pay_details(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT *
                 FROM fixed_pays
                 WHERE fixed_pay_id = (SELECT fixed_pay_id
                                       FROM vendors_fixed_pays
                                       WHERE history_flag = 0
                                       AND vendor_id = "+vendor_id.to_s+")"

     fixed_pay_details = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     fixed_pay_details

  end

  def self.get_last_paid_details(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT transaction_amount,transaction_date
                 FROM vendor_transactions
                 WHERE transaction_date  = (SELECT MAX(transaction_date)
                                            FROM vendor_transactions
                                            WHERE history_flag = 0
                                            AND vendor_id = "+vendor_id.to_s+")"

     last_paid_details = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     last_paid_details

  end

  def self.get_next_payment_details(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT f.subscription_cost as next_payment_cost,
                        date_add(v.subscribed_date, interval f.subscription_period month) as next_payment_date
                 FROM vendors_fixed_pays v
                 INNER JOIN
                 fixed_pays f
                 WHERE v.vendor_id = "+vendor_id.to_s+"
                 AND v.history_flag = 0
                 AND v.fixed_pay_id = f.fixed_pay_id"

     next_payment_details = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     next_payment_details

  end

  def self.get_cut_off_period(vendor_id)

    connection_hash = configurations["monetization_dev"]

    establish_connection connection_hash

    con = connection()

          sql = "SELECT cut_off_period
                 FROM cut_off_periods
                 WHERE cut_off_period_id = (SELECT
                                            cut_off_period_id
                                            FROM vendors_fixed_pays
                                            WHERE  history_flag= 0
                                            AND vendor_id = "+vendor_id.to_s+")"

     cut_off_period = con.execute(sql)

     remove_connection

     establish_connection configurations["RAILS_ENV"]

     cut_off_period

  end


end


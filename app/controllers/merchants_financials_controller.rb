class MerchantsFinancialsController < ApplicationController

   before_filter :login_required , :set_cache_buster

   include MerchantsFinancialsHelper

  def index

    @from = "financials"

    current_merchant

    @vendor_id = @current_merchant.vendor_id

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

    @options = @vendor.first.sub_categories.collect {|p| [p.category_name, p.sub_category_id] }.unshift(["All Categories", 0])

    @vendor.each do |vendor|
      @vendor_name = vendor.vendor_name
      @vendor_id = vendor.vendor_id
      @monetization_type = vendor.monetization_type
    end

    if @monetization_type == 'fixed'

      self.fixed

    elsif @monetization_type == 'variable'

      self.variable

    elsif @monetization_type == 'purchase'

      self.purchase

    end



  end

  def fixed

    #merchants_index_preliminary_actions

    @no_pay_flag = 0

    @no_subscribe_flag = 0

    @no_next_pay_flag = 0

    @no_cut_off_period = 0

    fixed_pay_details = MonetizationFixed.get_fixed_pay_details(@vendor_id).first

    last_paid_details = MonetizationFixed.get_last_paid_details(@vendor_id).first

    next_payment_details = MonetizationFixed.get_next_payment_details(@vendor_id).first

    cut_off_period = MonetizationFixed.get_cut_off_period(@vendor_id).first

    if !(fixed_pay_details.nil? || fixed_pay_details.empty?)

        @subscription_cost = fixed_pay_details[1]

        @subscription_period = fixed_pay_details[2]

    else

        @no_subscribe_flag = 1

        @message = "Your subscription is not reflected in CrawlFish db, yet!"


    end

    if !(last_paid_details.nil? || last_paid_details.empty?)

        @last_paid_amount = last_paid_details[0]

        @last_paid_date = last_paid_details[1]

    else

        @no_pay_flag = 1

        @message = "You have not made any payment to CrawlFish, yet!"

    end

    if !(next_payment_details.nil? || next_payment_details.empty?)

        @next_payment_amount = next_payment_details[0]

        @next_payment_date = next_payment_details[1]

    else

        @no_next_pay_flag = 1

        @message = "Next payment is not generated, yet!"

    end

    if !(cut_off_period.nil? || cut_off_period.empty?)

        @cut_off_period = cut_off_period[0]

    else

        @no_cut_off_period = 1

        @message = "Your cut off period is not fixed, yet!"

    end

    @fixed_product_listings = VendorProductTransactionsLogs.get_fixed_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])


    render ("merchants_financials/fixed")

  end

  def fixed_paginate

    puts"========INSIDE fixed_paginate============"

    @sub_category_id = params[:sub_category_id].to_i if params[:sub_category_id]

    @current_merchant = current_merchant

    @vendor_id = @current_merchant.vendor_id

    @type = @current_merchant.business_type


    if @sub_category_id.nil?

      @fixed_product_listings = VendorProductTransactionsLogs.get_fixed_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page] || nil)

    else

      @fixed_product_listings = VendorProductTransactionsLogs.get_fixed_product_listing(@vendor_id,@sub_category_id).paginate(:per_page => 2, :page => params[:page] || nil)

    end

    render :partial => ("merchants_financials/fixed_table")

  end

  def variable_paginate

    puts"========INSIDE variable_paginate============"

    @sub_category_id = params[:sub_category_id].to_i if params[:sub_category_id]

    @current_merchant = current_merchant

    @vendor_id = @current_merchant.vendor_id

    @type = @current_merchant.business_type


    if @sub_category_id.nil?

      @variable_product_listings = VendorProductTransactionsLogs.get_variable_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page] || nil)

    else

      @variable_product_listings = VendorProductTransactionsLogs.get_variable_product_listing(@vendor_id,@sub_category_id).paginate(:per_page => 2, :page => params[:page] || nil)

    end

    render :partial => ("merchants_financials/variable_table")


  end

  def purchase_paginate

    puts"========INSIDE purchase_paginate============"

    @sub_category_id = params[:sub_category_id].to_i if params[:sub_category_id]

    @current_merchant = current_merchant

    @vendor_id = @current_merchant.vendor_id

    @type = @current_merchant.business_type


    if @sub_category_id.nil?

      @purchase_product_listings = VendorProductPurchasesLogs.get_purchase_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page] || nil)

    else

      @purchase_product_listings = VendorProductPurchasesLogs.get_purchase_product_listing(@vendor_id,@sub_category_id).paginate(:per_page => 2, :page => params[:page] || nil)

    end

    render :partial => ("merchants_financials/purchase_table")


  end

  def variable

    #merchants_index_preliminary_actions

    @no_impression_rate = 0

    @no_button_click_rate = 0

    @no_cut_off_period = 0

    @no_cut_off_amount = 0

    @no_sub_category_id_commission = 0

    impression_rate = MonetizationVariable.get_accepted_impressions_rate(@vendor_id).first

    button_click_rate = MonetizationVariable.get_accepted_button_clicks_rate(@vendor_id).first

    cut_off_period = MonetizationVariable.get_cut_off_period(@vendor_id).first

    cut_off_amount = MonetizationVariable.get_cut_off_amount(@vendor_id).first

    sub_category_id_commission = MonetizationPurchase.get_sub_category_id_commission(@vendor_id)



     if !(impression_rate.nil? || impression_rate.empty?)

        @impression_rate = impression_rate[0]

    else

        @no_impression_rate = 1

        @message = "Your impression rate is not updated, yet!"

    end

     if !(button_click_rate.nil? || button_click_rate.empty?)

        @button_click_rate = button_click_rate[0]

    else

        @no_button_click_rate = 1

        @message = "Your button click rate is not updated, yet!"

    end

     if !(cut_off_period.nil? || cut_off_period.empty?)

        @cut_off_period = cut_off_period[0]

    else

        @no_cut_off_period = 1

        @message = "Your cut off period is not fixed, yet!"

    end

    if !(cut_off_amount.nil? || cut_off_amount.empty?)

        @cut_off_amount = cut_off_amount[0]

    else

        @no_cut_off_amount = 1

        @message = "Your cut off amount is not fixed, yet!"

    end

     if !(sub_category_id_commission.nil? || sub_category_id_commission.empty?)

      @sub_category_id_commission = sub_category_id_commission

    else

        @no_sub_category_id_commission = 1

        @message = "This commission is not updated, yet!"

    end

     @variable_product_listings = VendorProductTransactionsLogs.get_variable_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])


    @purchase_product_listings =  VendorProductPurchasesLogs.get_purchase_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])


    render ("merchants_financials/variable")

  end

  def i_c_paginate

    puts"========INSIDE i_c_paginate============"

    @sub_category_id = params[:sub_category_id].to_i if params[:sub_category_id]

    @current_merchant = current_merchant

    @vendor_id = @current_merchant.vendor_id

    @type = @current_merchant.business_type


    if @sub_category_id.nil?

      @impressions_clicks_product_listings = VendorProductTransactionsLogs.get_impressions_clicks_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])

    else

      @impressions_clicks_product_listings = VendorProductTransactionsLogs.get_impressions_clicks_product_listing(@vendor_id,@sub_category_id).paginate(:per_page => 2, :page => params[:page])

    end

    render :partial => ("merchants_financials/impressions_clicks")


  end

  def purchase

    #merchants_index_preliminary_actions

    @no_sub_category_id_commission = 0

    @no_cut_off_period = 0

     sub_category_id_commission = MonetizationPurchase.get_sub_category_id_commission(@vendor_id)

     cut_off_period = MonetizationPurchase.get_cut_off_period(@vendor_id).first

      if !(cut_off_period.nil? || cut_off_period.empty?)

        @cut_off_period = cut_off_period[0]

    else

        @no_cut_off_period = 1

        @message = "Your cut off period is not fixed, yet!"

    end



      if !(sub_category_id_commission.nil? || sub_category_id_commission.empty?)

      @sub_category_id_commission = sub_category_id_commission

    else

        @no_sub_category_id_commission = 1

        @message = "This commission is not updated, yet!"

    end

    @purchase_product_listings =  VendorProductPurchasesLogs.get_purchase_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])

     @impressions_clicks_product_listings = VendorProductTransactionsLogs.get_impressions_clicks_product_listing(@vendor_id).paginate(:per_page => 2, :page => params[:page])

     render ("merchants_financials/purchase")

  end


end


class MerchantsDashboardController < ApplicationController

  before_filter :login_required , :set_cache_buster


  def index

      @from = "dashboard"

      current_merchant

      @type = @current_merchant.business_type

      @vendor = VendorsList.where(:vendor_id => @current_merchant.vendor_id)

      @vendor_id = @current_merchant.vendor_id

	    @impressions = VendorProductTransactionsLogs.get_total_count(@vendor_id,"page_impressions_count")

	    @clicks = VendorProductTransactionsLogs.get_total_count(@vendor_id,"button_clicks_count")

	    @options = @vendor.first.sub_categories.collect {|p| [p.category_name, p.sub_category_id] }.unshift(["All Categories", 0])

	    impressions_result = VendorProductTransactionsLogs.get_most_recognized_impressions(@vendor_id)

      clicks_result  = VendorProductTransactionsLogs.get_most_recognized_clicks(@vendor_id)

	    if impressions_result == 1

	      @most_recognized_impressions = "No data to calculate the most recognized category!"

    	 else

    	   @most_recognized_impressions = impressions_result.join

      end

      if clicks_result == 1

         @most_recognized_clicks = "No data to calculate the most recognized category!"

       else

         @most_recognized_clicks = clicks_result.join

       end


  end

  def data_feed
    	    merchants_index_preliminary_actions

            render ('merchants_dashboard/data_feed')
  end

  def categorize

    if !(params[:vendor_id].to_i == 0)


        @sub_category_id = params[:sub_category_id].to_i

        @vendor_id = params[:vendor_id].to_i

        puts "this is sub_category_id #{@sub_category_id}"

        @impressions = VendorProductTransactionsLogs.get_total_count(@vendor_id,"page_impressions_count",@sub_category_id)

        @clicks = VendorProductTransactionsLogs.get_total_count(@vendor_id,"button_clicks_count",@sub_category_id)


        puts "this is impressions #{@total_impressions}.."

        puts "this is clicks #{@total_clicks}..."

         render :partial => "merchants_dashboard/impressions_clicks"

   else

     @message = "Invalid vendor or category!"

     render "merchants/message"

   end

  end

  def range

    from_date = params[:from_date].to_s

    to_date = params[:to_date].to_s

    sub_category_id = params[:sub_category_id].to_i

    vendor_id = params[:vendor_id].to_i

    puts "the value of vendor_id is #{vendor_id}.."

    puts "the value of sub_category_id is #{sub_category_id}.."


    @impressions = VendorProductTransactionsLogs.get_range("page_impressions_count",vendor_id,from_date,to_date,sub_category_id)

    @clicks = VendorProductTransactionsLogs.get_range("button_clicks_count",vendor_id,from_date,to_date,sub_category_id)


    render :partial => "merchants_dashboard/impressions_clicks"

  end


end


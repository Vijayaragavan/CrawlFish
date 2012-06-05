class MerchantsSessionsController < ApplicationController
 
  def index

	  @merchants=Merchants.new
	  @db_merchants=Array.new
	  render('merchants_sessions/forgot_password')

  end

  def create

	if !params[:merchants][:login_name].nil?
		@login_name = params[:merchants][:login_name].to_s
        end

	@merchants=Merchants.new
	
	@db_merchants = Merchants.where(:login_name => @login_name).first

	if(@db_merchants.nil?)
		@message = @login_name + " is not registered as a merchant with CrawlFish. Please enter a valid login name"
		render('merchants_sessions/forgot_password')
	else
		if !(@db_merchants.vendor_id.nil?)
			@password_request=MerchantsPasswordRequests.new
			@password_request.request=@login_name + " has asked for password reset"
			@password_request.request_type="forgot_password"
			@password_request.merchant_id=@db_merchants.merchant_id
			
			if @password_request.save
				render('merchants_sessions/password_req_success')
			else
				@message="Your request was not submitted successfully.Please try again!"
				render('merchants_sessions/forgot_password')
			end
      		else
        		@message = @login_name + " is not registered as a merchant with CrawlFish. Please enter a valid login name"
			render('merchants_sessions/forgot_password')
		end
	end

	
  end

end


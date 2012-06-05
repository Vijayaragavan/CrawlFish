class FooterController < ApplicationController
  def about_us

	  @online_vendor_count=VendorsList.count(:conditions => { :business_type => "online" })

	  @local_vendor_count=VendorsList.count(:conditions => { :business_type => "local" })

	  @books_count=BooksList.count

	  @mobiles_count=MobilesLists.count

  end

  def faq
  end

  def overview
	render :partial => "footer/about_us_overview"
  end

  def whatwedo
	render :partial => "footer/about_us_what_we_do"
  end

  def whatwebelieve
	render :partial => "footer/about_us_what_we_believe"
  end

  def c101
	render :partial => "footer/faq_c101"
  end

  def cfaq
	render :partial => "footer/faq_cfaq"
  end

  def merchant_login

    current_merchant

    if !(@current_merchant.nil?)

      redirect_to :controller => "merchants_dashboard", :action => "index"

    else

      redirect_to :controller => "merchants", :action => "home"

    end

  end

  def privacy_statement
  end

  def speak_to_us
	@speaktous = SpeakToUs.new
    	self.set_flash
  end
  
  def speak_to_us_submit
	
	self.speak_to_us_initialize
	
	@speaktous = SpeakToUs.new
	@speaktous.name=@stus_name
	@speaktous.email=@stus_emailid
	@speaktous.contact_number=@stus_number
	@speaktous.message=@stus_message
	
	if @stus_flag==0
		@speaktous.advertisement_flag='y'
	elsif @stus_flag==3
		@speaktous.query_flag='y'
	elsif @stus_flag==1
		@speaktous.suggestion_flag='y'
	elsif @stus_flag==2
		@speaktous.defect_flag='y'
	end

	if @speaktous.save
		redirect_to :controller => 'footer', :action => 'speak_to_us' ,:flash => "create_speaktous"
	else
		redirect_to :controller => 'footer', :action => 'speak_to_us' ,:flash => "no_create_speaktous"
	end

  end
  
  def set_flash

	if !params[:flash].nil?
		@flash = params[:flash].to_s
	else
	        @flash = nil
	end

  end

  def speak_to_us_initialize

  	if !params[:speak_to_us][:name].nil?
		@stus_name = params[:speak_to_us][:name].to_s
        end
	if !params[:speak_to_us][:contact_number].nil?
		@stus_number = params[:speak_to_us][:contact_number].to_s
        end
	if !params[:speak_to_us][:email].nil?
		@stus_emailid = params[:speak_to_us][:email].to_s
        end
	if !params[:speak_to_us][:message].nil?
		@stus_message = params[:speak_to_us][:message].to_s
        end
	if !params[:sts_flag].nil?
		@stus_flag = params[:sts_flag].to_i
	end

  end

end



class MerchantsListsController < ApplicationController

  def new

    @merchants_list = MerchantsLists.new

  end

  def create

    merchants_home_preliminary_actions

    @type = params[:type].to_s

    puts "Im in merchants_lists/create"

    if @type == "local"

    puts "Im in merchants_lists/create.....LOCAL"

      @area = params[:area]
      @city = params[:city]

      @merchants_list = MerchantsLists.new(params[:merchants_lists])
      @merchants_list.business_type = @type
      @merchants_list.city_name = @city
      @merchants_list.branch_name = @area

    elsif @type == "online"

          puts "Im in merchants_lists/create....ONLINE"

      @merchants_list = MerchantsLists.new(params[:merchants_lists])
      @merchants_list.business_type = @type

    end

    logo_path = General.data_file_upload(params[:upload],@merchants_list.merchant_name+"_logo")[2]

    @merchants_list.merchant_logo = logo_path

    if @merchants_list.save

       @message = "Your request to become a vendor at CrawlFish has been taken, we will revert in 23 hours!"
       render 'merchants/success'

    else
        @error_flag = 1
        render 'merchants/home'
    end

  end

  def show_sign_up

    @merchants_list = MerchantsLists.new
    type_id = params[:type_id]
    city_id = params[:city_id]
    area_id = params[:area_id]

    if type_id.to_i == 0

      @message = "Please pick your business type!"

      render "merchants/message"

    elsif type_id.to_i == 1 && city_id.to_i == 0 && area_id.to_i == 0

      @message = "Please pick your city and area!"

      render "merchants/message"

    elsif type_id.to_i == 1 && area_id.to_i == 0

      @message = "Please pick your area!"

      render "merchants/message"

    elsif type_id.to_i == 2

      @type = "online"

      render :partial => "merchants_lists/online_sign_up"

    else

        @type = "local"

        @city = (Cities.where(:city_id => city_id).map &:city_name).join

        @area = (Branches.where(:branch_id => area_id).map &:branch_name).join

        render :partial => "merchants_lists/local_sign_up"

    end

  end

  def show_areas

    if params[:id].present?
     @areas = Cities.where(:city_id => params[:id]).first.branches
    else
      @areas = []
    end

     render :partial => "merchants_lists/areas", :locals => { :areas => @areas }

  end



end


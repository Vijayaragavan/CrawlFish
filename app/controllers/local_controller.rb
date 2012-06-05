class LocalController < ApplicationController

# functions defined after this section are direct
#================ Direct Functions - START ================
  def index

  end

  def show_local_shop

      set_sub_categories

      self.set_product_id_sub_category_id

      self.set_vendor_id

      set_sub_category_name(@sub_category_id)

      set_product

      self.set_local_grid

      self.set_vendor

      self.set_vendor_name

      self.set_areas
		
      self.set_current_branch_id_branch_name

      self.set_deal_flag

      self.set_unique_id
      
      self.get_deal_info

      render ('local/local_shop')

  end

  def show_gmap

      self.set_vendor_name_branch_name

      @latitude_longitude = VendorsList.get_latitude_longitude(f_stripstring(@vendor_name),f_stripstring(@branch_name))

      render :partial => "local/gmap"

  end

  def change_vendor_details

    self.set_vendor_id

    self.set_vendor

    render :partial => "local/local_shop_details"

  end

  def send_sms

    self.set_type_phone_number

    self.set_product_id_sub_category_id

    self.set_vendor_id

    Sms.raise_request(@type,@phone_number,@vendor_id,@product_id,@sub_category_id)

    render :nothing => true

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_type_phone_number

    if !params[:type].nil? && !params[:phone_number].nil?

      @type = params[:type].to_s

      @phone_number = params[:phone_number].to_s

    end

  end

  def set_vendor_name_branch_name

    if !params[:vendor_name].nil? && !params[:branch_name].nil?

      @vendor_name = params[:vendor_name].to_s

      @branch_name = params[:branch_name].to_s

    end

  end

  def set_product_id_sub_category_id

     if !params[:product_id].nil? && !params[:sub_category_id].nil?

       @sub_category_id = params[:sub_category_id].to_i

       @product_id = params[:product_id].to_i

     end

  end

  def set_vendor_id

    if !(params[:vendor_id].nil?)

      @vendor_id = params[:vendor_id].to_i

    end

  end
  
  def set_unique_id

    if !(params[:unique_id].nil?)

      @unique_id = params[:unique_id].to_i

    end

  end

  def set_deal_flag
     
     if !(params[:deal].nil?)

	@deal_flag = params[:deal].to_i

     end

  end

  def set_vendor

      @vendor =  VendorsList.where(:vendor_id => @vendor_id)

  end

  def set_vendor_name

    @vendor_name = @vendor.map{|i| i.vendor_name.downcase}.join

  end

  def set_areas

    @areas =   Branches.get_vendor_id_branch_name(@vendor_name,@product_id,@sub_category_id)

  end

  def set_current_branch_id_branch_name

    @current_branch = Branches.get_current_branch(@vendor_id)

  end
  def set_local_grid

    if !(params[:unique_id].nil?)

      @local_grid = LocalGridDetails.where(:unique_id => params[:unique_id].to_i)

    end

  end
  
  def get_deal_info

	@deal_info = ProductDeals.get_deal_info_local(@product_id,@unique_id)
	puts @deal_info

  end
  #================ Auxillary Functions - END================

end


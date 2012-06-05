class MerchantsProductsController < ApplicationController

   before_filter :login_required , :set_cache_buster

   respond_to :html, :js

# functions defined after this section are direct
#================ Direct Functions - START ================

   def search

     self.merchants_index_preliminary_actions

     self.set_searched_products

   end

   def index

    self.set_flash

    self.merchants_index_preliminary_actions

    self.set_vendor_products

     respond_with

   end

   def new

     self.set_type_vendor

          if @type == "local"

            @merchants_product = LocalMerchantProducts.new
            @merchants_product.product_delivery_cost = ""

          elsif @type == "online"

            @merchants_product = OnlineMerchantProducts.new
            @merchants_product.product_shipping_cost = ""

          end

  end

  def create

    self.merchants_index_preliminary_actions

    if @type == "local"

      @merchants_product = LocalMerchantProducts.new(params[:local_merchant_products])


    elsif @type == "online"

      @merchants_product = OnlineMerchantProducts.new(params[:online_merchant_products])

    end

    @merchants_product.reason = ""
    @merchants_product.validity = ""
    @merchants_product.configured_by = ""
    @merchants_product.vendor_id = @vendor_id
    @merchants_product.vendor_table_name = to_u(@model_name)
    @merchants_product.action = params[:merchant_action]
    @merchants_product.part1_product_id = 0 # since part_product_id cannot be null, assigning 0

    if @merchants_product.save

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "create_success"

    else

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "create_close"

    end

  end

  def edit

     self.set_type_model_name

     @part1_product = @model_name.constantize.where(:product_id => params[:part1_product_id].to_i).first

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new
       @merchants_product.product_delivery = @part1_product.product_delivery
       @merchants_product.product_delivery_time = @part1_product.product_delivery_time
       @merchants_product.product_delivery_cost = @part1_product.product_delivery_cost

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new
       @merchants_product.product_redirect_url = @part1_product.product_redirect_url
       @merchants_product.product_shipping_time = @part1_product.product_shipping_time
       @merchants_product.product_shipping_cost = @part1_product.product_shipping_cost

     end

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params

  end

  def update

     self.merchants_index_preliminary_actions

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new(params[:local_merchant_products])

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new(params[:online_merchant_products])

     end

     @merchants_product.part1_product_id = params[:part1_product_id]
     @merchants_product.vendor_id = @vendor_id
     @merchants_product.vendor_table_name = to_u(@model_name)
     @merchants_product.action = params[:merchant_action]
     @merchants_product.product_sub_category = params[:product_sub_category]
     @merchants_product.reason = params[:reason]
     @merchants_product.validity = params[:validity]
     @merchants_product.configured_by = params[:configured_by]
     @merchants_product.product_image_url = params[:product_image_url]


     if @merchants_product.save

        redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "edit_success"

      else

        redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "edit_close"

      end

  end

  def delete

    self.set_type

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new

     end

  end

  def destroy

     self.merchants_index_preliminary_actions

     @part1_product = @model_name.constantize.where(:product_id => params[:part1_product_id]).first

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new
       @merchants_product.product_delivery = @part1_product.product_delivery
       @merchants_product.product_delivery_time = @part1_product.product_delivery_time
       @merchants_product.product_delivery_cost = @part1_product.product_delivery_cost

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new
       @merchants_product.product_redirect_url = @part1_product.product_redirect_url
       @merchants_product.product_shipping_time = @part1_product.product_shipping_time
       @merchants_product.product_shipping_cost = @part1_product.product_shipping_cost

     end

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params


     if @merchants_product.save

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "delete_success"

    else

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "delete_close"

    end

  end
#================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def merchants_index_preliminary_actions

      current_merchant

      @model_name = @current_merchant.table_name.camelize

      @type = @current_merchant.business_type

      @vendor_id = @current_merchant.vendor_id

      @from = "catalogue"

  end

  def set_flash

    if !params[:flash].nil?

      @flash = params[:flash].to_s

    else

      @flash = nil

    end

  end

  def set_searched_products

    @products =  @model_name.constantize.where('product_name like ?',"%#{params[:query]}%").paginate(:per_page => 5, :page => params[:page] || nil)

  end

  def set_vendor_products

    @products = @model_name.constantize.all.paginate(:per_page => 5 , :page => params[:page])

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

  end

  def set_merchants_product_similar_columns

     @merchants_product.product_name = @part1_product.product_name
     @merchants_product.product_image_url = @part1_product.product_image_url
     @merchants_product.product_category = @part1_product.product_category
     @merchants_product.product_sub_category = @part1_product.product_sub_category
     @merchants_product.product_identifier1 = @part1_product.product_identifier1
     @merchants_product.product_identifier2 = @part1_product.product_identifier2
     @merchants_product.product_price = @part1_product.product_price
     @merchants_product.product_availability = @part1_product.product_availability
     @merchants_product.product_special_offers = @part1_product.product_special_offers
     @merchants_product.product_warranty = @part1_product.product_warranty
     @merchants_product.reason = @part1_product.reason
     @merchants_product.validity = @part1_product.validity
     @merchants_product.configured_by = @part1_product.configured_by
     @merchants_product.part1_product_id = @part1_product.product_id
     @merchants_product.vendor_id = @vendor_id
     @merchants_product.vendor_table_name = to_u(@model_name)

  end

  def set_merchants_product_from_params

     @merchants_product.action = params[:merchant_action]

  end

  def set_type

    current_merchant

    @type = @current_merchant.business_type

  end

  def set_type_model_name

    current_merchant

    @type = @current_merchant.business_type

    @model_name = @current_merchant.table_name.camelize

  end

  def set_type_vendor

    current_merchant

    @type = @current_merchant.business_type

    @vendor_id = @current_merchant.vendor_id

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

  end


#================ Auxillary Functions - END ================


end


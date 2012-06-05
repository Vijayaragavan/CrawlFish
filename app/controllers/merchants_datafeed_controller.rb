class MerchantsDatafeedController < ApplicationController

   before_filter :login_required , :set_cache_buster

# functions defined after this section are direct
#================ Direct Functions - START ================

  def index
     self.datafeed_index_preliminary_actions
     render ("merchants_datafeed/upload")
  end


  def upload

    self.datafeed_index_preliminary_actions
    result = General.data_file_upload(params[:upload],@current_merchant.table_name)
    @fileName=result[0]
    @fileSize=result[1]
    render ("merchants_datafeed/upload_success")

  end

  #================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

   def datafeed_index_preliminary_actions

      current_merchant

      @type = @current_merchant.business_type

      @vendor_id = @current_merchant.vendor_id

      @vendor = VendorsList.where(:vendor_id => @vendor_id)

      @from = "datafeed"

  end

  #================ Auxillary Functions - END ================

end


class MobilesF1MobileBrand < ActiveRecord::Base

  def self.get_mobile_brand_names(mobile_brand_id)

    where("mobile_brand_id IN (?)", mobile_brand_id ).select("mobile_brand_name").map {|v| v.mobile_brand_name}

  end
end


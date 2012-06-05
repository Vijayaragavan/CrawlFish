class MobilesF2MobileColor < ActiveRecord::Base

  def self.get_mobile_color_names(mobile_color_id)

    where("mobile_color_id IN (?)", mobile_color_id ).select("mobile_color_name").map {|v| v.mobile_color_name}

  end

end


class MobilesF4MobileDesign < ActiveRecord::Base

  def self.get_mobile_design_names(mobile_design_id)

    where("mobile_design_id IN (?)", mobile_design_id ).select("mobile_design_name").map {|v| v.mobile_design_name}

  end
end


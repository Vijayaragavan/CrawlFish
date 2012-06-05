class MobilesF3MobileType < ActiveRecord::Base

  def self.get_mobile_type_names(mobile_type_id)

    where("mobile_type_id IN (?)", mobile_type_id ).select("mobile_type_name").map {|v| v.mobile_type_name}

  end
end


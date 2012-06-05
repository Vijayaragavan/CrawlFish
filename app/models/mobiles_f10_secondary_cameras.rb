class MobilesF10SecondaryCameras < ActiveRecord::Base

  def self.get_secondary_cameras(secondary_camera_id)

    where("secondary_camera_id IN (?)", secondary_camera_id ).select("secondary_camera").map {|v| v.secondary_camera}

  end

end


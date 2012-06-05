class MobilesF5OsVersion < ActiveRecord::Base

  def self.get_mobile_os_versions(mobile_os_id)

    where("mobile_os_version_id IN (?)", mobile_os_id ).select("mobile_os_version").map {|v| v.mobile_os_version}

  end

  def self.get_mobile_os_version_names(mobile_os_id)

    where("mobile_os_id IN (?)", mobile_os_id ).select("mobile_os_version_name").map {|v| v.mobile_os_version_name}

  end

end


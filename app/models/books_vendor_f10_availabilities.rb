class BooksVendorF10Availabilities < ActiveRecord::Base

  def self.get_availability_ids(excludable_availabilities = ["default"])

    where("f_stripstring(availability) IN (?)",excludable_availabilities.map{ |i| i.downcase.squeeze(" ").gsub(/ /,"").gsub(/,.-/,"") }).select("availability_id").map &:availability_id

  end

end


class MobilesF15Assorteds < ActiveRecord::Base

  def self.get_assorted_names(assorteds_id)

    where("assorteds_id IN (?)", assorteds_id ).select("assorteds_name").map {|v| v.assorteds_name}

  end

end


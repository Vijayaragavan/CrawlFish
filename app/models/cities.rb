class Cities < ActiveRecord::Base

  has_many :branches , :class_name => "Branches", :foreign_key => "city_id"

end


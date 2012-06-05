class OnlineVendorsConfigLogs < ActiveRecord::Base
  belongs_to :products, :class_name => "OnlineFlipkartProducts", :foreign_key => "product_id"
end


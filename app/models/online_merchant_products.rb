class OnlineMerchantProducts < ActiveRecord::Base

   validates :product_name, :presence => true

   validates :product_image_url, :presence => true

   validates :product_category, :presence => true,
				:inclusion => { :in => %w(books mobiles),
				:message => "%{value} is not a valid Category.Select among books and mobiles" }

   validates :product_sub_category, :presence => true,
				    :inclusion => { :in => %w(books mobiles),
     			            :message => "%{value} is not a valid SubCategory.Select among books and mobiles" }

   validates :product_identifier1, :presence => true,
				   :format => { :with => /[A-Za-z0-9]+/ }

   validates :product_identifier2, :presence => true,
				   :format => { :with => /[A-Za-z0-9]+/ }

   validates :product_price, 	   :presence => true,
				   :format => { :with => /[0-9]+/ ,:message => "Enter a valid price"}

   validates :product_availability, :presence => true
   
   validates :product_shipping_cost, :presence => true

   validates :product_shipping_time, :presence => true
				   
   validates :product_redirect_url, :presence => true,
				    :format => {:with => /(^((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]*)+.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/i}
 


end


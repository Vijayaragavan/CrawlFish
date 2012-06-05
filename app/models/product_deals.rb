class ProductDeals < ActiveRecord::Base

  def self.get_online_deal
 	
	joins("INNER JOIN online_grid_details ON online_grid_details.unique_id = product_deals.unique_id").where("product_deals.business_type = ?",'online').select("product_deals.*,online_grid_details.redirect_url")

  end

  def self.get_local_deal
 	
	where("product_deals.business_type = ?",'local').select("product_deals.*")

  end

  def self.get_deal_info_local(product_id,unique_id)
	
	where("product_deals.business_type = ? AND product_id = ? AND unique_id = ?",'local',product_id,unique_id).select("product_deals.deal_info").map &:deal_info

  end

end

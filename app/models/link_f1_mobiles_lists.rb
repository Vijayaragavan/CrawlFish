class LinkF1MobilesLists < ActiveRecord::Base

  def self.get_mobile_brand_ids(mobiles_list_id)

    where("mobiles_list_id IN (?)",mobiles_list_id.map {|x| x} ).select("distinct mobile_brand_id").map &:mobile_brand_id

  end

  def self.get_similar_brand_unique_id(product_id,sub_category_id,unique_id)

    joins("INNER JOIN link_f1_mobiles_lists as ml1
ON link_f1_mobiles_lists.mobile_brand_id != ml1.mobile_brand_id
INNER JOIN link_products_lists_vendors
ON link_products_lists_vendors.products_list_id =
link_f1_mobiles_lists.mobiles_list_id").where("ml1.mobiles_list_id = ?
AND link_products_lists_vendors.sub_category_id = ?
AND link_products_lists_vendors.products_list_id != ? AND link_products_lists_vendors.unique_id IN (?) ",product_id,sub_category_id,product_id,unique_id).select("unique_id").map &:unique_id

  end

end


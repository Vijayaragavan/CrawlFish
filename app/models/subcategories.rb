class Subcategories < ActiveRecord::Base

  has_many :filtercollections, :class_name => "FiltersCollection", :foreign_key => "sub_category_id"

  def self.fetch_all_ids

    select("sub_category_id").map &:sub_category_id

  end

  def self.what_is_my_name(sub_category_id)

    where("sub_category_id = ?",sub_category_id).select("sub_category_name").map &:sub_category_name

  end

  def self.what_is_my_category(sub_category_id)

    where("sub_category_id = ?",sub_category_id).select("category_name").map &:category_name

  end



end


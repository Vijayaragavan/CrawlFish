class Sms < ActiveRecord::Base

  def self.raise_request(type,phone_number,vendor_id,product_id,sub_category_id)

    if type.to_s == "mobile"

      create(:mobile_number => phone_number,:vendor_id => vendor_id,:product_id => product_id,:sub_category_id => sub_category_id)

      puts "SMS LOGGER: Sms request raised for #{type}, #{phone_number},#{vendor_id},#{product_id},#{sub_category_id}"

    elsif type.to_s == "landline"

      create(:landline_number => phone_number,:vendor_id => vendor_id,:product_id => product_id,:sub_category_id => sub_category_id)

      puts "SMS LOGGER: Sms request raised for #{type}, #{phone_number},#{vendor_id},#{product_id},#{sub_category_id}"

    end

  end


end


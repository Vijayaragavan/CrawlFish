module MerchantsFinancialsHelper

  def set_fixed_logs

    @fixed_logs = Array.new

    @vendor_product_transaction_log.each do |log|

          log_hash = Hash.new

            log_hash[:product_id] = log.product_id

            log_hash[:sub_category_id] = log.sub_category_id

          if Subcategories.what_is_my_name(log.sub_category_id).flatten.join == "books_lists"

            log_hash[:products] = BooksList.get_book_name(log.product_id).join

          elsif Subcategories.what_is_my_name(log.sub_category_id).flatten.join == "mobiles_lists"

            log_hash[:products] = MobilesLists.get_mobile_name(log.product_id).join

          end

          log_hash[:impressions] = log.impression_count

          log_hash[:clicks] = log.click_count

          @fixed_logs << log_hash

      end

  end

  def set_variable_logs(fixed_logs)

    variable_logs = Array.new

    fixed_logs.each do |log|

          log_hash = Hash.new

          if Subcategories.what_is_my_name(log.sub_category_id).flatten.join == "books_lists"

            log_hash[:products] = BooksList.get_book_name(log.product_id).join

          elsif Subcategories.what_is_my_name(log.sub_category_id).flatten.join == "mobiles_lists"

            log_hash[:products] = MobilesLists.get_mobile_name(log.product_id).join

          end

          log_hash[:impressions] = log.impression_count

          log_hash[:clicks] = log.click_count

          @logs << log_hash

      end

      variable_logs

  end




end


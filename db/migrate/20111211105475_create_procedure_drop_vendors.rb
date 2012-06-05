class CreateProcedureDropVendors < ActiveRecord::Migration
 def up

     execute <<-SQL
    CREATE PROCEDURE p_drop_online_vendor(IN v_vendor_name VARCHAR(255))
     BEGIN


     DECLARE v_COUNT INT;

     DECLARE v_vendor_id INT;

     DECLARE v_unique_id BIGINT(15);



     SELECT COUNT(*) INTO v_COUNT
     FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name);

     IF v_COUNT = 1 THEN

     SELECT vendor_id INTO v_vendor_id
     FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name);


     DELETE FROM link_products_lists_vendors
     WHERE vendor_id = v_vendor_id;

     DELETE FROM fixed_pay_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM variable_pay_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM product_purchase_commission_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM link_f10_vendor_books_lists WHERE vendor_id = v_vendor_id;

     DELETE FROM link_f16_vendor_mobiles_lists WHERE vendor_id = v_vendor_id;
    
     /* added by senthil, since there is a foreign key constraint for vendors_lists and merchants in vendor_id */
     DELETE FROM merchants WHERE vendor_id = v_vendor_id;

     /* added by senthil, since there is a foreign key constraint for vendors_lists and online_merchant_products in vendor_id */
     DELETE FROM online_merchant_products WHERE vendor_id = v_vendor_id;

     DELETE FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name);


     END IF;

     END;

     SQL

     execute <<-SQL
    CREATE PROCEDURE p_drop_local_vendor(IN v_vendor_name VARCHAR(255),
                                         IN v_city_name VARCHAR(255),
                                         IN v_branch_name VARCHAR(255))

     BEGIN


     DECLARE v_COUNT INT;

     DECLARE v_vendor_id BIGINT;

     SELECT COUNT(*) INTO v_COUNT
     FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name)
     AND f_stripstring(city_name) = f_stripstring (v_city_name)
     AND f_stripstring(branch_name) = f_stripstring (v_branch_name);

     IF v_COUNT = 1 THEN

     SELECT vendor_id INTO v_vendor_id
     FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name)
     AND f_stripstring(city_name) = f_stripstring (v_city_name)
     AND f_stripstring(branch_name) = f_stripstring (v_branch_name);

     DELETE FROM link_products_lists_vendors
     WHERE vendor_id = v_vendor_id;

     DELETE FROM fixed_pay_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM variable_pay_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM product_purchase_commission_vendors WHERE vendor_id = v_vendor_id;

     DELETE FROM link_f10_vendor_books_lists WHERE vendor_id = v_vendor_id;

     DELETE FROM link_f16_vendor_mobiles_lists WHERE vendor_id = v_vendor_id;


     /* added by senthil, since there is a foreign key constraint for vendors_lists and merchants in vendor_id */
     DELETE FROM merchants WHERE vendor_id = v_vendor_id;

      /* added by senthil, since there is a foreign key constraint for vendors_lists and local_merchant_products in vendor_id */
     DELETE FROM local_merchant_products WHERE vendor_id = v_vendor_id;
 

     DELETE FROM vendors_lists
     WHERE f_stripstring(vendor_name) = f_stripstring (v_vendor_name)
     AND f_stripstring(city_name) = f_stripstring (v_city_name)
     AND f_stripstring(branch_name) = f_stripstring (v_branch_name);


     END IF;

     END;

     SQL

   end

  def down

    execute "DROP PROCEDURE p_drop_online_vendor"
    execute "DROP PROCEDURE p_drop_local_vendor"
  end
end


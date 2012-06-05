class CreateProcedureGatewayOfCrawlfish < ActiveRecord::Migration
def up
    execute "DROP PROCEDURE IF EXISTS p_gateway_of_crawlfish"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_of_crawlfish(IN v2_product_id INT,
                                            IN v2_sub_category VARCHAR(255),
                                            IN v2_debug_id VARCHAR(255),
					    IN v2_product_name VARCHAR(255),
                                            IN v2_identifier1 VARCHAR(255),
                                            IN v2_identifier2 VARCHAR(255),
					    IN v2_delete_flag INT)


    BEGIN

	IF v2_delete_flag = 0 THEN

	IF LOWER(v2_sub_category) = LOWER('books_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_books_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_books_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name,
                                         v2_identifier1,
                                         v2_identifier2);


	ELSEIF LOWER(v2_sub_category) = LOWER('mobiles_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_mobiles_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_mobiles_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name,
                                         v2_identifier1,
                                         v2_identifier2);



	ELSE

	call debug.debug_insert(v2_debug_id,'Some problem in procedure p_gateway_of_crawlfish');

	END IF;

	END IF;
 
    END;

  SQL

  end

  def down

    execute "DROP PROCEDURE p_gateway_of_crawlfish"

  end
end


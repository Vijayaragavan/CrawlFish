class CreateProcedureInsertPriorityErrors < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Insert_priority_errors"

    execute <<-SQL
    CREATE PROCEDURE p_Insert_priority_errors(IN v1_product_sub_category varchar(255),
					      IN v1_product_name VARCHAR(255),
					      IN v1_identifier1 VARCHAR(255),
                                              IN v1_identifier2 VARCHAR(255),
                                              IN v1_message VARCHAR(255),
                                              OUT v1_fixed_flag INT,
                                              IN v1_debug_id VARCHAR(255))
    BEGIN

    DECLARE v_count, v_pid, v_fixed INT;

    SELECT count(*),fixed INTO v_count, v_fixed FROM priority_errors
    WHERE (product_sub_category,product_name,identifier1,identifier2,message) = 
    (v1_product_sub_category,v1_product_name,v1_identifier1,v1_identifier2,v1_message);

    IF v_count = 1 AND v_fixed = 0 THEN

    SELECT id,count INTO v_pid,v_count FROM priority_errors WHERE (product_sub_category,product_name,identifier1,identifier2,message,fixed)
    = (v1_product_sub_category,v1_product_name,v1_identifier1,v1_identifier2,v1_message,v_fixed);

    UPDATE priority_errors SET count = (v_count+1)
    WHERE id = v_pid;

    SET v1_fixed_flag = 0;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,concat('Priority error updated for ',v1_product_sub_category,' ',v1_product_name,' ',v1_identifier1,' ',v1_identifier2,'    about a nanosecond ago'));

    ELSEIF v_count = 1 AND v_fixed = 1 THEN

    SET v1_fixed_flag = 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,concat('Serious issue in priority errors table. Check for ',v1_product_sub_category,' ',v1_product_name,' ',v1_identifier1,' ',v1_identifier2));


    ELSE

    INSERT INTO priority_errors(product_sub_category,product_name,identifier1,identifier2,message,count,fixed,created_at)
    VALUES(v1_product_sub_category,v1_product_name,v1_identifier1,v1_identifier2,v1_message,(v_count+1),0,now());

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debug_id,concat('Priority error found for ',v1_product_sub_category,' ',v1_product_name,' ',v1_identifier1,' ',v1_identifier2,' about a nanosecond ago'));

    SET v1_fixed_flag = 0;

    END IF;

  END;

  SQL

  end

  def down

    execute "DROP PROCEDURE p_Insert_priority_errors"

  end
end


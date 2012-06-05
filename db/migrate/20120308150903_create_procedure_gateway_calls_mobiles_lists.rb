class CreateProcedureGatewayCallsMobilesLists < ActiveRecord::Migration
def up
    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_mobiles_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_mobiles_lists(IN v3_product_id INT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255),
                                            IN v3_identifier1 VARCHAR(255),
                                            IN v3_identifier2 VARCHAR(255))


    BEGIN

    DECLARE v_product_features TEXT;
    DECLARE v_mobile_name,v_mobile_brand_name,v_mobile_color_name,v_mobile_type_name,v_mobile_design_name,v_mobile_os_version, v_mobile_os_version_name,v_release_date,v_touch_screen_name,v_memory_size,v_mobile_ram, v_internal_storage_name,v_card_slots,v_primary_camera,v_secondary_camera,v_processor,v_messaging_name,v_browser_name,v_assorteds_name VARCHAR(255);
    DECLARE v_mobile_brand_id,v_mobile_color_id,v_assorteds_id,v_mobile_ram_id,v_mobile_type_id,v_mobile_design_id, v_mobile_os_version_id,v_mobile_os_version_name_id,v_touch_screen_id,v_internal_storage_id,v_card_slot_id,v_primary_camera_id,v_secondary_camera_id, v_messaging_id,v_browser_id, v_release_date_id,v_processor_id,v_sub_category_id,v_mobiles_list_id INT;

    DECLARE done INT DEFAULT 0;

    DECLARE cur_mobile_types CURSOR FOR SELECT mobile_type_id FROM link_f3_mobiles_lists WHERE mobiles_list_id = v3_product_id;

    DECLARE cur_messaging CURSOR FOR SELECT messaging_id FROM link_f12_mobiles_lists WHERE mobiles_list_id = v3_product_id;

    DECLARE cur_browser CURSOR FOR SELECT browser_id FROM link_f13_mobiles_lists WHERE mobiles_list_id = v3_product_id;

    DECLARE cur_assorteds CURSOR FOR SELECT assorteds_id FROM link_f15_mobiles_lists WHERE mobiles_list_id = v3_product_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring ( v3_sub_category);



    /* ###########################========= mobile  ===============############*/

    /* selecting the mobile name from the part2 db in order to
    insert into the filters collections   */

    SELECT mobiles_list_id,mobile_name INTO v_mobiles_list_id,v_mobile_name
    FROM mobiles_lists
    WHERE mobile_brand  = v3_identifier1 AND mobile_color = v3_identifier2 AND mobile_name = v3_product_name;

    IF v_mobile_name IS NOT NULL AND v_mobiles_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_mobile_name,
                                       v_mobiles_list_id,
                                       "mobiles_lists",
                                       "mobile_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('mobile name ',v_mobile_name,
    ' is not inserted into products_filters'));

     END IF;

    /* ###########################========= mobile name end ===============############*/

    /* ###########################========= mobile brands ===============############*/
    /* selecting the mobile brand from the part2 db in order to
    insert into the filters collections   */

    SELECT mobile_brand_id  INTO v_mobile_brand_id
    FROM link_f1_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_mobile_brand_id IS NOT NULL THEN

    SELECT mobile_brand_name INTO v_mobile_brand_name
    FROM mobiles_f1_mobile_brands
    WHERE mobile_brand_id  = v_mobile_brand_id;

call p_Insert_filters_collections( NULL, v_mobile_brand_name,
                                       v_mobile_brand_id,
                                       "LinkF1MobilesLists",
                                       "mobile_brand_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_brand_name into filters ',v_mobile_brand_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_brand_name ',v_mobile_brand_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= mobile brands end ===============############*/

    /* ###########################========= mobile colors ===============############*/
    /* selecting the mobile color from the part2 db in order to
    insert into the filters collections   */

    SELECT mobile_color_id  INTO v_mobile_color_id
    FROM link_f2_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_mobile_color_id IS NOT NULL THEN

    SELECT mobile_color_name INTO v_mobile_color_name
    FROM mobiles_f2_mobile_colors
    WHERE mobile_color_id  = v_mobile_color_id;

    call p_Insert_filters_collections( NULL, v_mobile_color_name,
                                       v_mobile_color_id,
                                       "LinkF2MobilesLists",
                                       "mobile_color_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_color_name into filters ',v_mobile_color_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_color_name ',v_mobile_color_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= mobile colors end ===============############*/

    /* ###########################========= mobile types ===============############*/

    OPEN cur_mobile_types;

    WHILE NOT done DO
    FETCH cur_mobile_types INTO v_mobile_type_id;

    IF v_mobile_type_id IS NOT NULL THEN

    SELECT mobile_type_name INTO v_mobile_type_name
    FROM mobiles_f3_mobile_types
    WHERE mobile_type_id  = v_mobile_type_id;


call p_Insert_filters_collections( NULL, v_mobile_type_name,
                                       v_mobile_type_id,
                                       "LinkF3MobilesLists",
                                       "mobile_type_id",
                                       v_sub_category_id,
                                       v3_debug_id);


 /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_type_name into filters ',v_mobile_type_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Mobile type name is not inserted ',v_mobile_type_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_mobile_types;

     SET done = 0;



    /* ###########################========= mobile types end ===============############*/

    /* ###########################========= mobile designs ===============############*/
    /* selecting the mobile design from the part2 db in order to
    insert into the filters collections   */

    SELECT mobile_design_id  INTO v_mobile_design_id
    FROM link_f4_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_mobile_design_id IS NOT NULL THEN

    SELECT mobile_design_name INTO v_mobile_design_name
    FROM mobiles_f4_mobile_designs
    WHERE mobile_design_id  = v_mobile_design_id;

call p_Insert_filters_collections( NULL, v_mobile_design_name,
                                       v_mobile_design_id,
                                       "LinkF4MobilesLists",
                                       "mobile_design_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_design_name into filters ',v_mobile_design_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_design_name ',v_mobile_design_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= mobile designs end ===============############*/

    /* ###########################========= mobile os ===============############*/
    /* selecting the mobile os from the part2 db in order to
    insert into the filters collections   */

    SELECT mobile_os_version_id  INTO v_mobile_os_version_id
    FROM link_f5_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    SELECT mobile_os_version_name_id  INTO v_mobile_os_version_name_id
    FROM link_f5_c_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_mobile_os_version_id IS NOT NULL THEN

    SELECT mobile_os_version INTO v_mobile_os_version
    FROM mobiles_f5_os_versions
    WHERE mobile_os_version_id  = v_mobile_os_version_id;

    call p_Insert_filters_collections( NULL, v_mobile_os_version,
                                       v_mobile_os_version_id,
                                       "LinkF5MobilesLists",
                                       "mobile_os_version_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_os_version into filters ',v_mobile_os_version,' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_os_version ',v_mobile_os_version,' about a  nanosecond ago'));

    END IF;

    IF 	v_mobile_os_version_name_id IS NOT NULL THEN

    SELECT mobile_os_version_name INTO v_mobile_os_version_name
    FROM mobiles_f5_c_os_version_names
    WHERE mobile_os_version_name_id  = v_mobile_os_version_name_id;

    call p_Insert_filters_collections( NULL, v_mobile_os_version_name,
                                       v_mobile_os_version_name_id,
                                       "LinkF5CMobilesLists",
                                       "mobile_os_version_name_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_os_version_name into filters ',v_mobile_os_version_name,' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_os_version name ',v_mobile_os_version_name,' about a  nanosecond ago'));

    END IF;


   /* ###########################========= mobile os end ===============############*/


    /* ###########################========= touch screen ===============############*/
    /* selecting the touch screen from the part2 db in order to
    insert into the filters collections   */

    SELECT touch_screen_id  INTO v_touch_screen_id
    FROM link_f6_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_touch_screen_id IS NOT NULL THEN

    SELECT touch_screen_name INTO v_touch_screen_name
    FROM mobiles_f6_touch_screens
    WHERE touch_screen_id  = v_touch_screen_id;

call p_Insert_filters_collections( NULL, v_touch_screen_name,
                                       v_touch_screen_id,
                                       "LinkF6MobilesLists",
                                       "touch_screen_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a touch_screen into filters ',v_touch_screen_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the touch_screen ',v_touch_screen_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= touch screen end ===============############*/

    /* ###########################========= internal storage ===============############*/
    /* selecting the internal storage from the part2 db in order to
    insert into the filters collections   */

    SELECT internal_storage_id  INTO v_internal_storage_id
    FROM link_f7_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_internal_storage_id IS NOT NULL THEN

    SELECT internal_storage_name INTO v_internal_storage_name
    FROM mobiles_f7_internal_storages
    WHERE internal_storage_id  = v_internal_storage_id;

call p_Insert_filters_collections( NULL, v_internal_storage_name,
                                       v_internal_storage_id,
                                       "LinkF7MobilesLists",
                                       "internal_storage_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a internal_storage into filters ',v_internal_storage_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the internal_storage ',v_internal_storage_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= internal storage end ===============############*/

    /* ###########################========= card slot ===============############*/
    /* selecting the card slot from the part2 db in order to
    insert into the filters collections   */

    SELECT card_slot_id  INTO v_card_slot_id
    FROM link_f8_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_card_slot_id IS NOT NULL THEN

    SELECT card_slots INTO v_card_slots
    FROM mobiles_f8_card_slots
    WHERE card_slot_id  = v_card_slot_id;

    call p_Insert_filters_collections( NULL, v_card_slots,
                                       v_card_slot_id,
                                       "LinkF8MobilesLists",
                                       "card_slot_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a card_slot into filters ',v_card_slots,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the card_slot ',v_card_slots,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= card slot end ===============############*/

    /* ###########################========= primary camera ===============############*/
    /* selecting the primary camera from the part2 db in order to
    insert into the filters collections   */

    SELECT primary_camera_id  INTO v_primary_camera_id
    FROM link_f9_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_primary_camera_id IS NOT NULL THEN

    SELECT primary_camera INTO v_primary_camera
    FROM mobiles_f9_primary_cameras
    WHERE primary_camera_id  = v_primary_camera_id;

call p_Insert_filters_collections( NULL, v_primary_camera,
                                       v_primary_camera_id,
                                       "LinkF9MobilesLists",
                                       "primary_camera_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a primary_camera into filters ',v_primary_camera,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the primary_camera ',v_primary_camera,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= primary camera end ===============############*/

    /* ###########################========= secondary camera ===============############*/
    /* selecting the secondary camera from the part2 db in order to
    insert into the filters collections   */

    SELECT secondary_camera_id  INTO v_secondary_camera_id
    FROM link_f10_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_secondary_camera_id IS NOT NULL THEN

    SELECT secondary_camera INTO v_secondary_camera
    FROM mobiles_f10_secondary_cameras
    WHERE secondary_camera_id  = v_secondary_camera_id;

call p_Insert_filters_collections( NULL, v_secondary_camera,
                                       v_secondary_camera_id,
                                       "LinkF10MobilesLists",
                                       "secondary_camera_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a secondary_camera into filters ',v_secondary_camera,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the secondary_camera ',v_secondary_camera,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= secondary camera end ===============############*/

    /* ###########################========= processor ===============############*/
    /* selecting the processor from the part2 db in order to
    insert into the filters collections   */

    SELECT processor_id  INTO v_processor_id
    FROM link_f11_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_processor_id IS NOT NULL THEN

    SELECT processor INTO v_processor
    FROM mobiles_f11_processors
    WHERE processor_id  = v_processor_id;

call p_Insert_filters_collections( NULL, v_processor,
                                       v_processor_id,
                                       "LinkF11MobilesLists",
                                       "processor_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a processor into filters ',v_processor,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the processor ',v_processor,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= processor end ===============############*/

    /* ###########################========= messaging name ===============############*/
    /* selecting the messaging from the part2 db in order to
    insert into the filters collections   */

    OPEN cur_messaging;

    WHILE NOT done DO
    FETCH cur_messaging INTO v_messaging_id;

    IF v_messaging_id IS NOT NULL THEN

    SELECT messaging_name INTO v_messaging_name
    FROM mobiles_f12_messagings
    WHERE messaging_id  = v_messaging_id;


call p_Insert_filters_collections( NULL, v_messaging_name,
                                       v_messaging_id,
                                       "LinkF12MobilesLists",
                                       "messaging_id",
                                       v_sub_category_id,
                                       v3_debug_id);


 /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a messaging_name into filters ',v_messaging_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Messaging name is not inserted ',v_messaging_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_messaging;

     SET done = 0;


   /* ###########################========= messaging name end ===============############*/

    /* ###########################========= browser name ===============############*/
    /* selecting the browser from the part2 db in order to
    insert into the filters collections   */

    OPEN cur_browser;

    WHILE NOT done DO
    FETCH cur_browser INTO v_browser_id;

    IF v_browser_id IS NOT NULL THEN

    SELECT browser_name INTO v_browser_name
    FROM mobiles_f13_browsers
    WHERE browser_id  = v_browser_id;


call p_Insert_filters_collections( NULL, v_browser_name,
                                       v_browser_id,
                                       "LinkF13MobilesLists",
                                       "browser_id",
                                       v_sub_category_id,
                                       v3_debug_id);


 /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a browser_name into filters ',v_browser_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Browser name is not inserted ',v_browser_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_browser;

     SET done = 0;



   /* ###########################========= browser name end ===============############*/

    /* ###########################========= mobile RAM ===============############*/
    /* selecting the mobile RAM from the part2 db in order to
    insert into the filters collections   */

    SELECT mobile_ram_id  INTO v_mobile_ram_id
    FROM link_f14_mobiles_lists
    WHERE mobiles_list_id = v3_product_id;

    IF 	v_mobile_ram_id IS NOT NULL THEN

    SELECT mobile_ram INTO v_mobile_ram
    FROM mobiles_f14_mobile_rams
    WHERE mobile_ram_id  = v_mobile_ram_id;

call p_Insert_filters_collections( NULL, v_mobile_ram,
                                       v_mobile_ram_id,
                                       "LinkF14MobilesLists",
                                       "mobile_ram_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a mobile_ram into filters ',v_mobile_ram,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the mobile_ram ',v_mobile_ram,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= mobile RAM end ===============############*/


    /* ###########################========= assorteds name ===============############*/
    /* selecting the assorteds from the part2 db in order to
    insert into the filters collections   */

    OPEN cur_assorteds;

    WHILE NOT done DO
    FETCH cur_assorteds INTO v_assorteds_id;

    IF v_assorteds_id IS NOT NULL THEN

    SELECT assorteds_name INTO v_assorteds_name
    FROM mobiles_f15_assorteds
    WHERE assorteds_id  = v_assorteds_id;


call p_Insert_filters_collections( NULL, v_assorteds_name,
                                       v_assorteds_id,
                                       "LinkF15MobilesLists",
                                       "assorteds_id",
                                       v_sub_category_id,
                                       v3_debug_id);


 /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a assorteds_name into filters ',v_assorteds_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('assorteds name is not inserted ',v_assorteds_name,
    ' about a  nanosecond ago'));

    END IF;


    END WHILE;

    CLOSE cur_assorteds;

     SET done = 0;


   /* ###########################========= assorteds name end ===============############*/


  END;

  SQL

  end

  def down

    execute "DROP PROCEDURE p_gateway_calls_mobiles_lists"

  end
end


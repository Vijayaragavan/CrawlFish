class AddForeignKeyToMobileIndexLinkTables < ActiveRecord::Migration
   def up

    execute <<-SQL
      ALTER TABLE link_f1_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_1
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f1_mobiles_lists
        ADD CONSTRAINT fk1_links_mobile_brands
        FOREIGN KEY (mobile_brand_id)
        REFERENCES mobiles_f1_mobile_brands(mobile_brand_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f2_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_2
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f2_mobiles_lists
        ADD CONSTRAINT fk1_links_mobile_colors
        FOREIGN KEY (mobile_color_id)
        REFERENCES mobiles_f2_mobile_colors(mobile_color_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f3_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_3
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f3_mobiles_lists
        ADD CONSTRAINT fk1_links_mobile_types
        FOREIGN KEY (mobile_type_id)
        REFERENCES mobiles_f3_mobile_types(mobile_type_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f4_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_4
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f4_mobiles_lists
        ADD CONSTRAINT fk1_links_mobile_designs
        FOREIGN KEY (mobile_design_id)
        REFERENCES mobiles_f4_mobile_designs(mobile_design_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f5_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_5
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f5_mobiles_lists
        ADD CONSTRAINT fk1_links_operating_systems
        FOREIGN KEY (mobile_os_version_id)
        REFERENCES mobiles_f5_os_versions(mobile_os_version_id)
    SQL


    execute <<-SQL
      ALTER TABLE link_f6_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_6
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f6_mobiles_lists
        ADD CONSTRAINT fk1_links_touch_screens
        FOREIGN KEY (touch_screen_id)
        REFERENCES mobiles_f6_touch_screens(touch_screen_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f7_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_7
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

     execute <<-SQL
      ALTER TABLE link_f7_mobiles_lists
        ADD CONSTRAINT fk1_links_internal_storages
        FOREIGN KEY (internal_storage_id)
        REFERENCES mobiles_f7_internal_storages(internal_storage_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f8_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_8
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f8_mobiles_lists
        ADD CONSTRAINT fk1_links_card_slots
        FOREIGN KEY (card_slot_id)
        REFERENCES mobiles_f8_card_slots(card_slot_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f9_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_9
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f9_mobiles_lists
        ADD CONSTRAINT fk1_links_primary_cameras
        FOREIGN KEY (primary_camera_id)
        REFERENCES mobiles_f9_primary_cameras(primary_camera_id)
   SQL

    execute <<-SQL
      ALTER TABLE link_f10_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_10
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f10_mobiles_lists
        ADD CONSTRAINT fk1_links_secondary_cameras
        FOREIGN KEY (secondary_camera_id)
        REFERENCES mobiles_f10_secondary_cameras(secondary_camera_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f11_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_11
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f11_mobiles_lists
        ADD CONSTRAINT fk1_links_processors
        FOREIGN KEY (processor_id)
        REFERENCES mobiles_f11_processors(processor_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f12_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_12
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f12_mobiles_lists
        ADD CONSTRAINT fk1_links_messagings
        FOREIGN KEY (messaging_id)
        REFERENCES mobiles_f12_messagings(messaging_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f13_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_13
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f13_mobiles_lists
        ADD CONSTRAINT fk1_links_browsers
        FOREIGN KEY (browser_id)
        REFERENCES mobiles_f13_browsers(browser_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f14_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_14
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f14_mobiles_lists
        ADD CONSTRAINT fk1_links_mobile_rams
        FOREIGN KEY (mobile_ram_id)
        REFERENCES mobiles_f14_mobile_rams(mobile_ram_id)
    SQL


    execute <<-SQL
      ALTER TABLE link_f15_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_15
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f15_mobiles_lists
        ADD CONSTRAINT fk1_links_assorteds
        FOREIGN KEY (assorteds_id)
        REFERENCES mobiles_f15_assorteds(assorteds_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f16_vendor_mobiles_lists
        ADD CONSTRAINT fk1_links_mobiles_16
        FOREIGN KEY (mobiles_list_id)
        REFERENCES mobiles_lists(mobiles_list_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f16_vendor_mobiles_lists
        ADD CONSTRAINT fk1_links_availabilities
        FOREIGN KEY (availability_id)
        REFERENCES mobiles_vendor_f16_availabilities(availability_id)
    SQL

    execute <<-SQL
      ALTER TABLE link_f16_vendor_mobiles_lists
        ADD CONSTRAINT fk1_links_availabilities_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    SQL


  end

  def down

    execute "ALTER TABLE link_f1_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_1"
    execute "ALTER TABLE link_f1_mobiles_lists DROP FOREIGN KEY fk1_links_mobile_brands"
    execute "ALTER TABLE link_f2_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_2"
    execute "ALTER TABLE link_f2_mobiles_lists DROP FOREIGN KEY fk1_links_mobile_colors"
    execute "ALTER TABLE link_f3_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_3"
    execute "ALTER TABLE link_f3_mobiles_lists DROP FOREIGN KEY fk1_links_mobile_types"
    execute "ALTER TABLE link_f4_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_4"
    execute "ALTER TABLE link_f4_mobiles_lists DROP FOREIGN KEY fk1_links_mobile_designs"
    execute "ALTER TABLE link_f5_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_5"
    execute "ALTER TABLE link_f5_mobiles_lists DROP FOREIGN KEY fk1_links_operating_systems"
    execute "ALTER TABLE link_f6_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_6"
    execute "ALTER TABLE link_f6_mobiles_lists DROP FOREIGN KEY fk1_links_touch_screens"
    execute "ALTER TABLE link_f7_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_7"
    execute "ALTER TABLE link_f7_mobiles_lists DROP FOREIGN KEY fk1_links_internal_storages"
    execute "ALTER TABLE link_f8_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_8"
    execute "ALTER TABLE link_f8_mobiles_lists DROP FOREIGN KEY fk1_links_card_slots"
    execute "ALTER TABLE link_f9_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_9"
    execute "ALTER TABLE link_f9_mobiles_lists DROP FOREIGN KEY fk1_links_primary_cameras"
    execute "ALTER TABLE link_f10_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_10"
    execute "ALTER TABLE link_f10_mobiles_lists DROP FOREIGN KEY fk1_links_secondary_cameras"
    execute "ALTER TABLE link_f11_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_11"
    execute "ALTER TABLE link_f11_mobiles_lists DROP FOREIGN KEY fk1_links_processors"
    execute "ALTER TABLE link_f12_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_12"
    execute "ALTER TABLE link_f12_mobiles_lists DROP FOREIGN KEY fk1_links_messagings"
    execute "ALTER TABLE link_f13_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_13"
    execute "ALTER TABLE link_f13_mobiles_lists DROP FOREIGN KEY fk1_links_browsers"
    execute "ALTER TABLE link_f14_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_14"
    execute "ALTER TABLE link_f14_mobiles_lists DROP FOREIGN KEY fk1_links_mobile_rams"
    execute "ALTER TABLE link_f15_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_15"
    execute "ALTER TABLE link_f15_mobiles_lists DROP FOREIGN KEY fk1_links_assorteds"
    execute "ALTER TABLE link_f16_vendor_mobiles_lists DROP FOREIGN KEY fk1_links_mobiles_16"
    execute "ALTER TABLE link_f16_vendor_mobiles_lists DROP FOREIGN KEY fk1_links_availabilities"
    execute "ALTER TABLE link_f16_vendor_mobiles_lists DROP FOREIGN KEY fk1_links_availabilities_vendors"



  end
end


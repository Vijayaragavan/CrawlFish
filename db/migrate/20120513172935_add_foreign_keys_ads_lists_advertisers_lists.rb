class AddForeignKeysAdsListsAdvertisersLists < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE ad_lists
        ADD CONSTRAINT fk_ad_lists_ad_banners
        FOREIGN KEY (banner_height,banner_width,duration)
        REFERENCES ad_banners(banner_height,banner_width,duration)
    SQL

  end

  def down
    execute "ALTER TABLE ad_lists DROP FOREIGN KEY fk_ad_lists_ad_banners"
  end
end

class InsertIntoTables < ActiveRecord::Migration
  def up

	execute "insert into subcategories(sub_category_name,category_id,category_name,created_at) values('books_lists',1,'books',now())"
	execute "insert into subcategories(sub_category_name,category_id,category_name,created_at) values('mobiles_lists',2,'mobiles',now())"

	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('in stock',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('out of stock',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('available',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('imported edition',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('pre order',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('forthcoming',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('out of print',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('permanently discontinued',now())"
	execute "insert into books_vendor_f10_availabilities(availability,created_at) values('coming soon',now())"

	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('imported edition',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('in stock',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('out of stock',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('available',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('pre order',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('forthcoming',now())"
	execute "insert into mobiles_vendor_f16_availabilities(availability,created_at) values('coming soon',now())"


	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('2g',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('3g',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('gprs',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('edge',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('internet',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('wlan',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('bluetooth',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('usb',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('video',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('radio',now())"
	execute "insert into mobiles_f15_assorteds(assorteds_name,created_at) values('gps',now())"

	execute "insert into cities(city_name,created_at) values('chennai',now())"

	execute "insert into branches(branch_name,city_id,created_at) values('velachery',1,now())"
	execute "insert into branches(branch_name,city_id,created_at) values('tnagar',1,now())"
	execute "insert into branches(branch_name,city_id,created_at) values('tambaram',1,now())"
	execute "insert into branches(branch_name,city_id,created_at) values('chrompet',1,now())"
        execute "insert into branches(branch_name,city_id,created_at) values('mambalam',1,now())" 

	execute "insert into ad_banners(banner_height,banner_width,duration,banner_cost,created_at) values(600,120,1,1000,now())"
	execute "insert into ad_banners(banner_height,banner_width,duration,banner_cost,created_at) values(600,160,1,1500,now())"
	execute "insert into ad_banners(banner_height,banner_width,duration,banner_cost,created_at) values(250,250,1,750,now())"

  end

  def down
  end
end

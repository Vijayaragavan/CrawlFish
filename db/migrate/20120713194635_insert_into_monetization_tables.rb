class InsertIntoMonetizationTables < ActiveRecord::Migration
  def up

	execute "insert into monetization.cut_off_periods(cut_off_period,created_at) values(5,now())"
	execute "insert into monetization.cut_off_periods(cut_off_period,created_at) values(10,now())"
	execute "insert into monetization.cut_off_periods(cut_off_period,created_at) values(15,now())"
	execute "insert into monetization.cut_off_periods(cut_off_period,created_at) values(20,now())"

	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(100,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(150,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(200,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(250,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(300,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(350,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(400,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(450,now())"
	execute "insert into monetization.cut_off_amounts(cut_off_amount,created_at) values(500,now())"

	execute "insert into monetization.fixed_pays(subscription_cost,subscription_period,created_at) values(200,1,now())"
	execute "insert into monetization.fixed_pays(subscription_cost,subscription_period,created_at) values(500,3,now())"
	execute "insert into monetization.fixed_pays(subscription_cost,subscription_period,created_at) values(900,6,now())"
	execute "insert into monetization.fixed_pays(subscription_cost,subscription_period,created_at) values(1700,9,now())"

	execute "insert into monetization.impression_rates(impression_rates,created_at) values(0.05,now())"
	execute "insert into monetization.impression_rates(impression_rates,created_at) values(0.1,now())"
	execute "insert into monetization.impression_rates(impression_rates,created_at) values(0.15,now())"
	execute "insert into monetization.impression_rates(impression_rates,created_at) values(0.2,now())"

	execute "insert into monetization.button_click_rates(button_click_rates,created_at) values(0.1,now())"
	execute "insert into monetization.button_click_rates(button_click_rates,created_at) values(0.2,now())"
	execute "insert into monetization.button_click_rates(button_click_rates,created_at) values(0.3,now())"
	execute "insert into monetization.button_click_rates(button_click_rates,created_at) values(0.4,now())"
	execute "insert into monetization.button_click_rates(button_click_rates,created_at) values(0.5,now())"

	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(1,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(2,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(3,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(4,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(5,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(6,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(7,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(8,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(9,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(10,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(11,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(12,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(13,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(14,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(15,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(16,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(17,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(18,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(19,now())"
	execute "insert into monetization.product_purchase_commissions(product_purchase_commissions,created_at) values(20,now())"
  end

  def down

  end
end

class CreateAdvertiserFinancials < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.advertiser_financials"

    execute <<-SQL
    CREATE TABLE monetization.advertiser_financials (
    advertiser_financial_id INT UNSIGNED AUTO_INCREMENT,
    advertiser_id INT UNSIGNED NOT NULL,
    ad_list_id INT UNSIGNED NOT NULL,
    subscribed_date DATE NOT NULL,
    notification_date DATE NOT NULL,
    cut_off_date DATE NOT NULL,
    amount DOUBLE NOT NULL,
    paid_flag INT UNSIGNED DEFAULT 0,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (advertiser_financial_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.advertiser_financials"
  end
end

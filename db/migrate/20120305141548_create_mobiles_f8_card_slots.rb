class CreateMobilesF8CardSlots < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_f8_card_slots"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_f8_card_slots (
  card_slot_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  card_slots VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (card_slot_id),
  UNIQUE(card_slots)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_f8_card_slots"
  end
end

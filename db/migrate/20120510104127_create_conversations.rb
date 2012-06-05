class CreateConversations < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS conversations"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS conversations (
  conversation_id int UNSIGNED NOT NULL AUTO_INCREMENT,
  conversation VARCHAR(255) NOT NULL,
  validity INT UNSIGNED NOT NULL,
  priority INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (conversation_id),
  UNIQUE (conversation,validity,priority)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE conversations"
  end
end


class Sender < ActiveRecord::Base

  has_many :senderlinks , :class_name => "Connector", :foreign_key => "sender_id"
   has_many :receivers, :through => :senderlinks , :class_name => "Receiver", :foreign_key => "receiver_id"

end


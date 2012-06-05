class Receiver < ActiveRecord::Base

  has_many :receiverlinks , :class_name => "Connector", :foreign_key => "receiver_id"
   has_many :senders, :through => :receiverlinks , :class_name => "Sender", :foreign_key => "sender_id"

end


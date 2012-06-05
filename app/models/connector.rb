class Connector < ActiveRecord::Base

  belongs_to :receivers, :class_name => "Sender", :foreign_key => "sender_id"
  belongs_to :senders, :class_name => "Receiver", :foreign_key => "receiver_id"
end


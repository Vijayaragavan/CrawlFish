class SpeakToUs < ActiveRecord::Base
validates :name, 		:presence => true,
                 		:length => {:minimum => 3},
                 		:format => { :with => /[A-Za-z]+/ }

validates :contact_number,   	:presence => true,
                             	:numericality => true,
                            	:length => { :minimum => 6 }


validates :email,   		:presence => true,
                           	:format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}


validates :message, 		:presence => true,
                    		:length => {:minimum => 10}
end

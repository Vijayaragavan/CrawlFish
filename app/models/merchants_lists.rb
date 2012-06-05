class MerchantsLists < ActiveRecord::Base

  validates :merchant_name, :presence => true,
                            :length => {:minimum => 3},

                            :format => { :with => /[A-Za-z]+/ }

  validates :merchant_email, :presence => true,
                             :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                             :uniqueness => true

  validates :merchant_phone, :presence => true,
                             :numericality => true,
                             :length => { :minimum => 6 },
                             :uniqueness => true

  validates :merchant_address, :presence => true,
                               :length => { :minimum => 10, :maximum => 500 }

  validates :merchant_website, :presence => true,
                               :format => {:with => /(^((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]*)+.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/i}


  validates :merchant_fax,  :presence => true,
                            :uniqueness => true,
                            :numericality => true

  #validates :merchant_logo, :presence => true

end


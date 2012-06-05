class Merchants < ActiveRecord::Base

  def self.authenticate(merchants)

    login_name = merchants[:login_name]
    password = merchants[:password]

    user = where(:login_name => login_name).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

end


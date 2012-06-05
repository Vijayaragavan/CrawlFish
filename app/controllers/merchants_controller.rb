class MerchantsController < ApplicationController


  def home

    merchants_home_preliminary_actions

  end

  def index

    merchants_index_preliminary_actions
	  render ('merchants/index')

  end

  def create

   	    user = Merchants.authenticate(params[:merchants])
	    if user
	      puts "OK"
	      session[:merchant_id] = user.merchant_id
	      session[:notice] = nil
	      redirect_to :controller => "merchants_dashboard", :action => "index"
	    else
	      puts "CANCEL"
	      @message = "Invalid email or password"
	      merchants_home_preliminary_actions
	      render ('merchants/home')
	    end

  end

  def destroy
    session[:merchant_id] = nil
    @message = "Logged out!"
    merchants_home_preliminary_actions
    render ('merchants/home')
  end


end


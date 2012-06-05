class MainController < ApplicationController
  def index
     timestamp = Time.now
     hour = timestamp.strftime("%H")
    if  hour >= "0" && hour <= "12"
      flash[:notice] = "Good Morning, Enter a product name."
    elsif hour > "12" && hour <= "16"
      flash[:notice] = "Good Afternoon, Enter a product name."
    elsif hour > "16" && hour < "24"
      flash[:notice] = "Good Evening, Enter a product name."
    end

    render ('shared/index')
  end
end


class ConverseController < ApplicationController

  def index


    @conversation = Conversation.where(:validity => 1).first(:order => "RAND()")
    if @conversation.priority == 0
      @conversation.validity = 0
      @conversation.save
    end

    #flash[:notice] = 'hello'
    #render ('sharndex')

  end

end


module ApplicationHelper


  def to_u(input)

    input.gsub!(/(.)([A-Z])/,'\1_\2').downcase!

  end



end


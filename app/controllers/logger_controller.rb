class LoggerController < ApplicationController


  def impressions

    if(!File.exist?("public/transactions_logs/"+Date.today.to_s+"/"))
	
	FileUtils.mkdir_p("public/transactions_logs/"+Date.today.to_s+"/")

    end

    self.index("public/transactions_logs/"+Date.today.to_s+"/")

    render :nothing => true

  end

  def clicks
   
   if(!File.exist?("public/transactions_logs/"+Date.today.to_s+"/"))
	
	FileUtils.mkdir_p("public/transactions_logs/"+Date.today.to_s+"/")

   end

    self.index("public/transactions_logs/"+Date.today.to_s+"/")

    render :nothing => true

  end

  def index(file_location)

    @session_id = get_session_id

    self.set_query

    self.set_type

    if @type == "impressions"

      content = self.set_unique_ids_array

    elsif @type == "clicks"

      content = self.set_unique_id

    end

    content = self.add_type_id(content.to_s)
    
    self.write_to_file("\n"+content,file_location)

    puts "LOGGER MESSAGE : #{content} is written to #{@session_id}"

  end


  def set_query

    if !(session[:query].nil?)

      @query = session[:query].to_s
      @query = @query.chomp.chomp("|")

    else

      @query="undefined" 

    end

  end

  def set_type

    if !(params[:type].nil?)

      @type = params[:type].to_s

    end

  end

  def get_session_id

    @session_id = request.session_options[:id]

  end

  def write_to_file(content,file_location)

    if(File.exist?(file_location+@session_id+'.dat'))
	    File.open(file_location+@session_id+'.dat', 'a') {|f| f.write(content) }
    else
    	    File.open(file_location+@session_id+'.dat', 'a') do |f|
		 f.write(Time.new) 
		 f.write(content)
	    end
    end

  end

  def set_unique_ids_array

     if !(params[:unique_ids_array].nil?)

       params[:unique_ids_array].squeeze(" ")

     else

       puts "LOGGER ERROR: params[:unique_ids_array] is nil"

     end

   end

   def set_unique_id

     if !(params[:unique_id].nil?)

       params[:unique_id].to_i

     else

       puts "LOGGER ERROR: params[:unique_id] is nil"

     end

   end

   def add_type_id(content)

     if !(@session_id.nil?)

       content + "|" + @type + "|" + @query 

     else

       puts "LOGGER ERROR: @session_id is nil"

     end

   end


end


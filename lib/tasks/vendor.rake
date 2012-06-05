require "fileutils"
namespace :vendor do

  desc "Load records into vendor tables"
  task :test do

    puts "hi- from vendor"
    args = {:msg => "parameter from vendor", :number => 2}
    Rake::Task["merchant:test"].execute(args)

  end

##########################################LOAD ONLINE###############################################################

  desc "Load records into vendor tables"
  task :loadonline do
  puts "_"
  puts "_"
  puts "Remember, the data file's name you are trying to load should be in the format, Online_<<vendor_name>>_<<sub_category_name>>"
  puts "_"
  puts "_"
  puts "Checking DATA_FILE_NAME for correct naming convention..."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  file_name_prefix = ENV['DATA_FILE_PATH'].split("/").last.split("_")[0].downcase
  if !(file_name_prefix == "online")

    abort("Sorry, wrong file name, bring a right file or here is a simple tip, change this file name to this format, |Online_<<vendor_name>>_<<sub_category_name>>|")

  else
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "Right file name!!!"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "Starting to load data into CrawlFish database.."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "The process to add a vendor to the CrawlFish database started..."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "============ PLEASE REMOVE THE GENERATED MIGRATION FROM #{ENV['APP_PATH']}/db/migrate, IF RAKE IS ABORTED FOR ANY REASON.==========="
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  business_type = 'online'

      FileUtils.cd(ENV['APP_PATH']+"/db/migrate",:verbose => true)

  dir_name = "vendors_load_files"
  vendor_name = ENV['VENDOR_NAME'].downcase
  file_name = Dir["*load_#{business_type}_#{vendor_name}_products_*"][0]

  puts "file_name is #{file_name}"

  if file_name == nil
  migrationName = "Load"+business_type.capitalize+ENV['VENDOR_NAME'].capitalize+"Products_1"
  count = migrationName.split("_")[1]
  else
	if File.directory? dir_name
	puts "Directory #{dir_name} exists"
	else
	FileUtils.mkdir dir_name, :mode => 0700,  :verbose => true
	end
  number = file_name.split("_")[5].split(".")[0]
  number = (number).to_i + 1
  count = number.to_s

  migrationName = "Load"+business_type.capitalize+ENV['VENDOR_NAME'].capitalize+"Products_"+count
  end

      FileUtils.cd(ENV['APP_PATH'],:verbose => true)

  puts "count is #{count}"

  puts "rails generate migration #{migrationName}, will be executed"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  templateName = ENV['APP_PATH']+"/db/templates/loadOnlineVendorsTemplate.sql"

  puts "A SQL template to configure this migration will be taken from #{templateName}"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "start configure and create migration..."
  configure_migration("load",create_migration(count,"load_",
                                       migrationName,
                                       templateName,
				       business_type),
                        ENV['VENDOR_NAME'].downcase,
                        business_type,
                        ENV['DATA_FILE_PATH'],
			count)

   puts "Finish configure and create migration..."

  FileUtils.cd(ENV['APP_PATH']+"/db/migrate",:verbose => true)

  if file_name == nil
  puts "This is the first migration file for this vendor"
  else
  FileUtils.mv file_name, ENV['APP_PATH']+"/db/migrate/"+dir_name
  puts "Previous migration #{file_name} has been moved to the directiory #{dir_name}"
  end

  FileUtils.cd(ENV['APP_PATH'],:verbose => true)

    system 'rake db:migrate'

  end

  end

##########################################LOAD ONLINE END##########################################################

##########################################LOAD LOCAL###############################################################

  desc "Load records into vendor tables"
  task :loadlocal do
  puts "_"
  puts "_"
  puts "Remember, the data file's name you are trying to load should be in the format, Offline_<<vendor_name>>_<<sub_category_name>>"
  puts "_"
  puts "_"
  puts "Checking DATA_FILE_NAME for correct naming convention..."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  file_name_prefix = ENV['DATA_FILE_PATH'].split("/").last.split("_")[0].downcase
  if !(file_name_prefix == "offline")

    abort("Sorry, wrong file name, bring a right file or here is a simple tip, change this file name to this format, |Offline_<<vendor_name>>_<<sub_category_name>>|")

  else
  puts "Right file name!"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "=========================================================================================="
  puts "Starting to load data into CrawlFish database.."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "The process to add a vendor to the CrawlFish database started..."
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "============ PLEASE REMOVE THE GENERATED MIGRATION FROM #{ENV['APP_PATH']}/db/migrate, IF RAKE IS ABORTED FOR ANY REASON.==========="
  puts "_"
  puts "_"
  puts "_"
  puts "_"

  business_type = 'local'

      FileUtils.cd(ENV['APP_PATH']+"/db/migrate",:verbose => true)

  dir_name = "vendors_load_files"
  vendor_name = ENV['VENDOR_NAME'].downcase
  city_name = ENV['CITY_NAME'].downcase
  branch_name = ENV['BRANCH_NAME'].downcase
  file_name = Dir["*load_#{business_type}_#{city_name}_#{branch_name}_#{vendor_name}_products_*"][0]

  puts "file_name is #{file_name}"

  if file_name == nil
  migrationName = "Load"+business_type.capitalize+ENV['CITY_NAME'].capitalize+ENV['BRANCH_NAME'].capitalize+ENV['VENDOR_NAME'].capitalize+"Products_1"
  count = migrationName.split("_")[1]
  else
	if File.directory? dir_name
	puts "Directory #{dir_name} exists"
	else
	FileUtils.mkdir dir_name, :mode => 0700,  :verbose => true
	end
  number = file_name.split("_")[7].split(".")[0]
  number = (number).to_i + 1
  count = number.to_s


  migrationName = "Load"+business_type.capitalize+ENV['CITY_NAME'].capitalize+ENV['BRANCH_NAME'].capitalize+ENV['VENDOR_NAME'].capitalize+"Products_"+count
  end

      FileUtils.cd(ENV['APP_PATH'],:verbose => true)

  puts "count is #{count}"



  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "rails generate migration #{migrationName}, will be executed"
  templateName = ENV['APP_PATH']+"/db/templates/loadLocalVendorsTemplate.sql"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  puts "A SQL template to configure this migration will be taken from #{templateName}"
  puts "_"
  puts "_"
  puts "_"
  puts "_"
  configure_migration("load",create_migration(count,"load_",
                                        migrationName,
                                        templateName,
					business_type,
					ENV['CITY_NAME'].downcase,
		                        ENV['BRANCH_NAME'].downcase),
                        ENV['VENDOR_NAME'].downcase,
                        business_type,
                        ENV['DATA_FILE_PATH'],
			count,
                        ENV['CITY_NAME'].downcase,
                        ENV['BRANCH_NAME'].downcase)


  FileUtils.cd(ENV['APP_PATH']+"/db/migrate",:verbose => true)

  if file_name == nil
  puts "This is the first migration file for this vendor"
  else
  FileUtils.mv file_name, ENV['APP_PATH']+"/db/migrate/"+dir_name
  puts "Previous migration #{file_name} has been moved to the directiory #{dir_name}"
  end

  FileUtils.cd(ENV['APP_PATH'],:verbose => true)

    system 'rake db:migrate'

  end

  end

##########################################LOAD LOCAL END##########################################################


#################################################ADD LOCAL#######################################################
  desc "Add a vendor to the CrawlFish database"
  task :addlocal do |t,args|

    business_type = 'local'

    puts "The process to add a vendor to the CrawlFish database started..."
    puts "============ PLEASE REMOVE THE GENERATED MIGRATION FROM #{ENV['APP_PATH']}/db/migrate, IF RAKE IS ABORTED FOR ANY REASON.==========="
    migrationName = business_type.capitalize+ENV['CITY_NAME'].capitalize+ENV['BRANCH_NAME'].capitalize+ENV['VENDOR_NAME'].capitalize+"Products"

    puts "rails generate migration #{migrationName}, will be executed"
    templateName = ENV['APP_PATH']+"/db/templates/addLocalVendorsTemplate.sql"

    puts "A SQL template to configure this migration will be taken from #{templateName}"
    configure_migration("add",create_migration(0,"create_",
                                         migrationName,
                                         templateName,
                                         business_type,
                                         ENV['CITY_NAME'].downcase,
                                         ENV['BRANCH_NAME'].downcase),
                        ENV['VENDOR_NAME'],
                        business_type,
                        0,
			0,
                        ENV['CITY_NAME'],
                        ENV['BRANCH_NAME'],
			ENV['SUB_CATEGORIES'].downcase,
			ENV['MONETIZATION_TYPE'].downcase,
			ENV['SUBSCRIBED_DATE'],
                        ENV['VENDOR_LOGO'],
                        ENV['VENDOR_WEBSITE'],
                        ENV['EMAIL'],
                        ENV['PHONE'],
                        ENV['VENDOR_FAX'],
                        ENV['ADDRESS'],
                        ENV['LATITUDE'],
                        ENV['LONGITUDE'],
                        ENV['DESCRIPTION'],
                        ENV['WORKING_TIME'],
                        ENV['MISCELLANEOUS'])


    system 'rake db:migrate'

    #merchant_args = {:part1_table_name => migrationName.gsub!(/(.)([A-Z])/,'\1_\2').downcase! }

    #Rake::Task["merchant:approved"].execute(merchant_args)

  end
################################################################ADD LOCAL END#######################################################################

#################################################ADD ONLINE#########################################################
  desc "Add a vendor to the CrawlFish database"
  task :addonline do |t,args|

    business_type = 'online'

    puts "The process to add a vendor to the CrawlFish database started..."
    puts "============ PLEASE REMOVE THE GENERATED MIGRATION FROM #{ENV['APP_PATH']}/db/migrate, IF RAKE IS ABORTED FOR ANY REASON.==========="
    migrationName = business_type.capitalize+ENV['VENDOR_NAME'].capitalize+"Products"

    puts "rails generate migration #{migrationName}, will be executed"
    templateName = ENV['APP_PATH']+"/db/templates/addOnlineVendorsTemplate.sql"

    puts "A SQL template to configure this migration will be taken from #{templateName}"
    configure_migration("add",create_migration(0,"create_",
                                         migrationName,
                                         templateName,
                                         business_type),                                         
                        ENV['VENDOR_NAME'],
                        business_type,
                        0,
			0,
                        ENV['CITY_NAME'],
                        ENV['BRANCH_NAME'],
                        ENV['SUB_CATEGORIES'].downcase,
			ENV['MONETIZATION_TYPE'].downcase,
			ENV['SUBSCRIBED_DATE'],
                        ENV['VENDOR_LOGO'],
                        ENV['VENDOR_WEBSITE'],
                        ENV['EMAIL'],
                        ENV['PHONE'],
                        ENV['VENDOR_FAX'],
                        ENV['ADDRESS'],
                        ENV['LATITUDE'],
                        ENV['LONGITUDE'],
                        ENV['DESCRIPTION'],
                        ENV['WORKING_TIME'],
                        ENV['MISCELLANEOUS'])

    system 'rake db:migrate'


  end
##############################################################ADD ONLINE END########################################################



  #This method will generate a migration and return the generated migration name
  def create_migration(count,task,migrationName,templateName,business_type,city_name="default",branch_name="default")

  puts "the value of task is #{task}.."

    if task == "load_"

      system "rails generate migration #{migrationName}"
      puts "rails generated the migration at #{Time.now}"

    elsif task == "create_"

      system "rails generate model #{migrationName}"
      puts "rails generated the migration at #{Time.now}"

    end

    if business_type == 'local' and task == "load_"

        source = File.open(templateName)
        searchedFile = Dir[ENV['APP_PATH']+"/db/migrate/*_"+task+business_type.downcase+"_"+city_name.downcase+"_"+branch_name.downcase+"_"+ENV['VENDOR_NAME'].downcase+"_"+"products_"+count+".rb"]
        puts "Searching for #{searchedFile}"
        puts "Searched file"
        #targetFileName = File.basename(searchFile[0])
        target = File.open(searchedFile[0], "w")

            puts "File opened"
        target.write( source.read(64) ) while not source.eof?

        source.close
        target.close
        puts "Reached target.close"

        return searchedFile[0]

    elsif business_type == 'local' and task == "create_"

        source = File.open(templateName)
        searchedFile = Dir[ENV['APP_PATH']+"/db/migrate/*_"+task+business_type.downcase+"_"+city_name.downcase+"_"+branch_name.downcase+"_"+ENV['VENDOR_NAME'].downcase+"_"+"products.rb"]
        puts "Searching for #{searchedFile}"
        puts "Searched file"
        #targetFileName = File.basename(searchFile[0])
        target = File.open(searchedFile[0], "w")

            puts "File opened"
        target.write( source.read(64) ) while not source.eof?

        source.close
        target.close
        puts "Reached target.close"

        return searchedFile[0]


    elsif business_type == 'online' and task == "load_"
        puts "Entered online create migration!!"

	puts "business type is #{city_name}"

        source = File.open(templateName)
        searchedFile = Dir[ENV['APP_PATH']+"/db/migrate/*_"+task+business_type.downcase+"_"+ENV['VENDOR_NAME'].downcase+"_"+"products_"+count+".rb"]

        puts "Searching for #{searchedFile}"
            puts "Searchedfile declared!!"

        #targetFileName = File.basename(searchFile[0])
        target = File.open(searchedFile[0], "w")
            puts "Target file opened!!"
        target.write( source.read(64) ) while not source.eof?

        source.close
        target.close

            puts "Going to return searched file!!"
        return searchedFile[0]


    elsif business_type == 'online' and task == "create_"
        puts "Entered online create migration!!"

	puts "business type is #{city_name}"

        source = File.open(templateName)
        searchedFile = Dir[ENV['APP_PATH']+"/db/migrate/*_"+task+business_type.downcase+"_"+ENV['VENDOR_NAME'].downcase+"_"+"products.rb"]

        puts "Searching for #{searchedFile}"
            puts "Searchedfile declared!!"

        #targetFileName = File.basename(searchFile[0])
        target = File.open(searchedFile[0], "w")
            puts "Target file opened!!"
        target.write( source.read(64) ) while not source.eof?

        source.close
        target.close

            puts "Going to return searched file!!"
        return searchedFile[0]



    else
        abort("Error while handling the file")
    end

 end

  # This method will accept a full path migration file and substitute it with the environment values passed
  def configure_migration(task,
                          migrationFile,
                          vendorName,
                          businessType,
                          dataFilePath,
			  count,
                          city_name = 0,
                          branch_name = 0,
			  subCategories = 0,
			  monetizationType = 0,
			  subscribedDate = 0,                        
                          vendorLogo = 0,
                          vendorWebsite = 0,
                          vendorEmail = 0,
                          vendorPhone = 0,
			  vendorFax = 0,
                          vendorAddress = 0,
                          latitude = 0,
                          longitude = 0,                          
                          description = 0,
                          working_time = 0,
                          miscellaneous = 0)
    text = File.read(migrationFile)

    if task == "add"
	if businessType == "local"

	text.gsub!(/<<vendor_name>>/,vendorName.downcase).gsub!(/<<business_type>>/,businessType).gsub!(/<<class_vendor_type>>/,businessType.capitalize).gsub!(/<<class_vendor_name>>/,vendorName.capitalize).gsub!(/<<vendor_logo>>/,vendorLogo).gsub!(/<<vendor_website>>/,vendorWebsite).gsub!(/<<vendor_email>>/,vendorEmail).gsub!(/<<vendor_phone>>/,vendorPhone).gsub!(/<<vendor_fax>>/,vendorFax).gsub!(/<<vendor_address>>/,vendorAddress).gsub!(/<<city_name>>/,city_name).gsub!(/<<branch_name>>/,branch_name).gsub!(/<<latitude>>/,latitude).gsub!(/<<longitude>>/,longitude).gsub!(/<<class_city_name>>/,city_name.capitalize).gsub!(/<<class_branch_name>>/,branch_name.capitalize).gsub!(/<<sub_categories>>/,subCategories).gsub!(/<<monetization_type>>/,monetizationType).gsub!(/<<subscribed_date>>/,subscribedDate).gsub!(/<<vendor_description>>/,description).gsub!(/<<working_time>>/,working_time).gsub!(/<<miscellaneous>>/,miscellaneous).gsub!(/<<capitalized_vendor_name>>/,vendorName)




	elsif businessType == "online"

	text.gsub!(/<<vendor_name>>/,vendorName.downcase).gsub!(/<<business_type>>/,businessType).gsub!(/<<class_vendor_type>>/,businessType.capitalize).gsub!(/<<class_vendor_name>>/,vendorName.capitalize).gsub!(/<<vendor_logo>>/,vendorLogo).gsub!(/<<vendor_website>>/,vendorWebsite).gsub!(/<<vendor_email>>/,vendorEmail).gsub!(/<<vendor_phone>>/,vendorPhone).gsub!(/<<vendor_fax>>/,vendorFax).gsub!(/<<vendor_address>>/,vendorAddress).gsub!(/<<city_name>>/,city_name).gsub!(/<<branch_name>>/,branch_name).gsub!(/<<latitude>>/,latitude).gsub!(/<<longitude>>/,longitude).gsub!(/<<sub_categories>>/,subCategories).gsub!(/<<monetization_type>>/,monetizationType).gsub!(/<<subscribed_date>>/,subscribedDate).gsub!(/<<vendor_description>>/,description).gsub!(/<<working_time>>/,working_time).gsub!(/<<miscellaneous>>/,miscellaneous).gsub!(/<<capitalized_vendor_name>>/,vendorName)

	else
	abort("Error while doing GSUB in add task")
	end

    elsif task == "load"

	if businessType == "online"

	    text.gsub!(/<<data_file_path>>/,dataFilePath).gsub!(/<<table_name>>/,businessType+"_"+vendorName.downcase+"_"+"products").gsub!(/<<class_vendor_type>>/,businessType.capitalize).gsub!(/<<class_vendor_name>>/,vendorName.capitalize).gsub!(/<<count>>/,count)

	elsif businessType == "local"

	    text.gsub!(/<<data_file_path>>/,dataFilePath).gsub!(/<<table_name>>/,businessType+"_"+city_name+"_"+branch_name+"_"+vendorName.downcase+"_"+"products").gsub!(/<<class_vendor_type>>/,businessType.capitalize).gsub!(/<<class_vendor_name>>/,vendorName.capitalize).gsub!(/<<class_city_name>>/,city_name.capitalize).gsub!(/<<class_branch_name>>/,branch_name.capitalize).gsub!(/<<count>>/,count)


	else
	abort("Error while doing GSUB in load task")
	end

    else
    abort("Error with Configure Migration method")
    end

      File.open(migrationFile, 'w') { |f| f.write(text) }

      puts "The generated migration has been configured!"
  end
end


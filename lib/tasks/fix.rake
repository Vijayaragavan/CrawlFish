require "fileutils"
namespace :app do

  desc "Run a fix"
  task :fix do |t|

    app_path = ENV['APP_PATH']
      if !(app_path[-1] == "/")

        app_path = app_path+"/"

      end

    puts "\n"
    puts "=============================================================="
    puts "FIX PROCESS STARTED.."
    puts "\n"
    puts "COMPLETE LOG LOCATED IN,"
    puts "\n"
    puts " #{(app_path+"log/fix")}"
    puts "\n"
    puts "--------------------------------------------------------------"
    puts "\n"
    puts "Brief summary:"
    puts "--------------"

    log_file = create_fix_logs(app_path)

    puts "\n"
    puts "\n"
    puts "============ CRAWLFISH APP FIX START ON #{Time.now}==========="
    puts "\n"


    bkp_directory_name = 'fix_bkp'

      fix_directory_name = 'fix'

      directories_to_be_explored = ["app","config","db","doc","lib","public","script"]

      puts "------------------------------------------------------""\n"
      puts "\n"
      puts "app_path is set to .. #{app_path}""\n"
      puts "\n"
      puts "bkp_directory_name is set to .. #{bkp_directory_name}""\n"
      puts "\n"
      puts "fix_directory_name is set to .. #{fix_directory_name}""\n"
      puts "\n"
      puts "------------------------------------------------------""\n"
      puts "\n"
      FileUtils.cd(app_path+fix_directory_name,:verbose => true)

      puts "Chaging directory to .. #{app_path+fix_directory_name}"
      puts "\n"

      if File.exist? bkp_directory_name
        if File.directory? bkp_directory_name
          FileUtils.rm_r bkp_directory_name, :force => true, :verbose => true
          puts "fix_bkp already exists, removing .. #{bkp_directory_name}"
          puts "\n"
        end
      end

      FileUtils.mkdir bkp_directory_name, :mode => 0700,  :verbose => true

      puts "Creating fix_bkp in .. #{app_path+fix_directory_name}"
      puts "\n"

      files_to_be_fixed = Array.new

      Dir.foreach(app_path+fix_directory_name) do |file|
           if File.exist? file
                   if !(File.directory? file)
                     files_to_be_fixed << file

                   end
           end
      end
      puts "------------------------------------------------------""\n"
      puts "\n"
      puts "Following files were detected in the fix directory..""\n"
      puts "\n"
      files_to_be_fixed.each do |i|
        puts "#{i}""\n"
      end
      puts "\n"
      puts "------------------------------------------------------""\n"
      puts "\n"

      Dir.glob(app_path+'*').each do |file|

        seek_and_fix(files_to_be_fixed,file,app_path,fix_directory_name,bkp_directory_name)

      end

      directories_to_be_explored.each do |directory|

              Dir.glob(app_path+directory+'/**/*').each do |file|

                seek_and_fix(files_to_be_fixed,file,app_path,fix_directory_name,bkp_directory_name)

              end
      end


  puts "============ CRAWLFISH APP FIX END ON #{Time.now}==========="
  puts "\n"

      FileUtils.cd(app_path)
      FileUtils.mv log_file, app_path+"log/fix"

      STDOUT.reopen(@orig_std_out)
      puts "\n"
      puts "=============================================================="
      puts "\n"





  end

  def seek_and_fix(files_to_be_fixed,file,app_path,fix_directory_name,bkp_directory_name)

              if !(File.directory? file)

                 if files_to_be_fixed.include?(File.basename(file))

                    file_location_in_app = File.dirname(file)
                    file_name = File.basename(file)

                     puts "======================================""\n"
                     puts "\n"
                     puts "=>Current file operation on .. #{file_name}""\n"

                     FileUtils.mv file , app_path+fix_directory_name+"/"+bkp_directory_name+"/"+file_name+".bkp",  :verbose => true

                     puts "=>Moved #{file_name}  ..from .. #{file_location_in_app} .. to .. #{app_path+fix_directory_name+"/"+bkp_directory_name} .. as  .. #{file_name+".bkp"} .. " "\n"

                     FileUtils.cp app_path+fix_directory_name+"/"+file_name, file_location_in_app,  :verbose => true

                     puts "=>Copied #{file_name} from #{app_path+fix_directory_name} to #{file_location_in_app}, which is the actual fix" "\n"
                     puts "\n"

                     puts "======================================""\n"
                     puts "\n"


               end
              end
   end

   def create_fix_logs(app_path)

    log_file_directory = "fix"
    log_file_name = Time.now.strftime("%Y%m%d%H%M%S")+"_FIX.log"

    @orig_std_out = STDOUT.clone
    STDOUT.reopen(File.open(log_file_name, 'w+'))


#puts "test to screen"

 #   $stdout.reopen(log_file_name, "w")
  #  $stdout.sync = true


    FileUtils.cd(app_path+"log")

        if !(File.directory? log_file_directory)

          FileUtils.mkdir log_file_directory, :mode => 0700

        end

      return app_path+log_file_name

   end

end


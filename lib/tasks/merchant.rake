namespace :merchant do

  desc "LOCAL:
        0. Check vendor present in vendors_lists and fetch vendor_id,
        1. Check vendor present in merchants_lists,
        2. Generate merchant_login_name,
        3. Generate merchant_password,
        4. Insert login_details into merchants table
        5. populate merchant_id in merchants_lists"

  task :approve_local,[:vendor_name,:city_name,:branch_name]  => [:environment]   do |t,args|
    puts "-"
    puts "-"
    puts "-"

    puts "This task will start approving a local merchant and make him a vendor in CrawlFish db..."

    puts "-"
    puts "-"
    puts "-"

    vendor_id_monetization_type = check_vendors_lists_fetch_vendor_id_monetization_type(args[:vendor_name].downcase,"local",args[:city_name].downcase,args[:branch_name].downcase)

    vendor_id = vendor_id_monetization_type[0]

    monetization_type = vendor_id_monetization_type[1]

    check_merchants_lists(args[:vendor_name].downcase,"local",args[:city_name].downcase,args[:branch_name].downcase)

    table_name = "local_"+args[:city_name].downcase+"_"+args[:branch_name].downcase+"_"+args[:vendor_name].downcase+"_products"

    login_name = generate_login_name(args[:vendor_name].downcase,args[:city_name].downcase,args[:branch_name].downcase)

    password = generate_random_password

    password_salt = BCrypt::Engine.generate_salt

    password_hash = BCrypt::Engine.hash_secret(password, password_salt)

    insert_into_merchants(login_name,password_hash,password_salt,table_name,args[:vendor_name].downcase,password,"local",vendor_id,monetization_type,args[:city_name].downcase,args[:branch_name].downcase)

    update_merchants_lists(args[:vendor_name].downcase,"local",login_name,args[:city_name].downcase,args[:branch_name].downcase)

    puts "LOCAL MERCHANT "+args[:vendor_name].upcase+" IS APPROVED!!"
    puts "-"
    puts "-"
    puts "-"

  end

  desc "ONLINE:
        0. Check vendor present in vendors_lists and fetch vendor_id,
        1. Check vendor present in merchants_lists,
        2. Generate merchant_login_name,
        3. Generate merchant_password,
        4. Insert login_details into merchants table
        5. populate merchant_id in merchants_lists"

  task :approve_online,[:vendor_name]  => [:environment]   do |t,args|
    puts "-"
    puts "-"
    puts "-"

    puts "This task will start approving an online merchant and make him a vendor in CrawlFish db..."

    puts "-"
    puts "-"
    puts "-"

    vendor_id_monetization_type = check_vendors_lists_fetch_vendor_id_monetization_type(args[:vendor_name].downcase,"online")

    vendor_id = vendor_id_monetization_type[0]

    monetization_type = vendor_id_monetization_type[1]

    check_merchants_lists(args[:vendor_name].downcase,"online")

    table_name = "online_"+args[:vendor_name].downcase+"_products"

    login_name = generate_login_name(args[:vendor_name].downcase)

    password = generate_random_password

    password_salt = BCrypt::Engine.generate_salt

    password_hash = BCrypt::Engine.hash_secret(password, password_salt)

    insert_into_merchants(login_name,password_hash,password_salt,table_name,args[:vendor_name].downcase,password,"online",vendor_id,monetization_type)

    update_merchants_lists(args[:vendor_name].downcase,"online",login_name)

    puts "ONLINE MERCHANT "+args[:vendor_name].upcase+" IS APPROVED!!"
    puts "-"
    puts "-"
    puts "-"

  end



  def check_merchants_lists(merchant_name,type,city_name = 0,branch_name = 0)

    if type.to_s == "local"

        select_sql = "SELECT COUNT(*) FROM merchants_lists WHERE f_stripstring(merchant_name) = '"+merchant_name.downcase+"' AND city_name = '"+city_name+"' AND branch_name = '"+branch_name+"'"

        v_count = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }.join

        if !(v_count == '0')

          puts "The local merchant - #{merchant_name} is present in merchants_lists"

        else

          abort("The local merchant - #{merchant_name} is not present in merchants_lists, MERCHANT "+merchant_name.upcase+" IS REJECTED!!")

        end

    elsif type.to_s == "online"

        select_sql = "SELECT COUNT(*) FROM merchants_lists WHERE f_stripstring(merchant_name) = '"+merchant_name.downcase+"'"

        v_count = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }.join

        if !(v_count == '0')

          puts "The online merchant - #{merchant_name} is present in merchants_lists"

        else

          abort("The online merchant - #{merchant_name} is not present in merchants_lists, MERCHANT "+merchant_name.upcase+" IS REJECTED!!")

        end

    end

  end

  def check_vendors_lists_fetch_vendor_id_monetization_type(merchant_name,type,city_name = 0,branch_name = 0)

    if type.to_s == "local"

    select_sql = "SELECT COUNT(*) FROM vendors_lists WHERE vendor_name = '"+merchant_name+"' AND city_name = '"+city_name+"' AND branch_name = '"+branch_name+"'"

    v_count = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }.join

        if !(v_count == '0')

          puts "The local vendor - #{merchant_name} is present in vendors_lists"

          select_sql = "SELECT vendor_id,monetization_type FROM vendors_lists WHERE vendor_name = '"+merchant_name+"' AND city_name = '"+city_name+"' AND branch_name = '"+branch_name+"'"

          vendor_id_monetization_type = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }[0]

        else

          abort("The vendor - #{merchant_name} is not present in vendors_lists, MERCHANT "+merchant_name.upcase+" IS REJECTED!!")

        end

    elsif type.to_s == "online"

      select_sql = "SELECT COUNT(*) FROM vendors_lists WHERE vendor_name = '"+merchant_name+"'"

      v_count = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }.join

        if !(v_count == '0')

          puts "The online vendor - #{merchant_name} is present in vendors_lists"

          select_sql = "SELECT vendor_id,monetization_type FROM vendors_lists WHERE vendor_name = '"+merchant_name+"'"

          vendor_id_monetization_type = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }[0]

        else

          abort("The vendor - #{merchant_name} is not present in vendors_lists, MERCHANT "+merchant_name.upcase+" IS REJECTED!!")

        end
    end

    vendor_id_monetization_type

  end

  def update_merchants_lists(merchant_name,type,login_name,city_name = 0,branch_name = 0)

    select_sql = "SELECT merchant_id FROM merchants WHERE login_name = '"+login_name+"'"

    merchant_id = ActiveRecord::Base.connection.execute(select_sql).map {|i| i }.join

    if type.to_s == "local"

      update_sql = "UPDATE merchants_lists SET merchant_id = #{merchant_id} WHERE merchant_name = '"+merchant_name+"' AND city_name = '"+city_name+"' AND branch_name = '"+branch_name+"' AND business_type = '"+type+"'"

    elsif type.to_s == "online"

      update_sql = "UPDATE merchants_lists SET merchant_id = #{merchant_id} WHERE merchant_name = '"+merchant_name+"' AND business_type = '"+type+"'"

    end

    ActiveRecord::Base.connection.execute(update_sql)

    puts "-"
    puts "-"
    puts "-"
    puts "Inserting the merchant id in merchants_lists..."
    puts "-"
    puts "-"
    puts "-"
    puts "The merchant_id - #{merchant_id} for the merchant - #{merchant_name} is inserted into the table merchants_lists"
    puts "-"
    puts "-"
    puts "-"

  end


  def insert_into_merchants(login_name,password_hash,password_salt,table_name,vendor_name,password,type,vendor_id,monetization_type,city_name = 0,branch_name = 0)

    current_date = Time.now.strftime("%Y%b%d")

    current_time = Time.now.strftime("%I:%M%p")

    log_file_name = 'merchants/'+current_date+"_"+type+"_"+vendor_name+'.log'

    puts "Do you want to go ahead and approve this vendor? (y/n)"

    answer = STDIN.gets.chomp.downcase

    if answer == 'y'

        db_name = ActiveRecord::Base.connection.current_database

        sql = "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = "+"'"+table_name+"'"+" AND table_schema = "+"'"+db_name+"'"

          count = (ActiveRecord::Base.connection.execute(sql).map &:first).join.to_i

          if count == 1

              sql = "INSERT INTO merchants(login_name,password_hash,password_salt,table_name,business_type,vendor_id) VALUES('#{login_name}','#{password_hash}','#{password_salt}','#{table_name}','#{type}',#{vendor_id})"

              begin

                ActiveRecord::Base.connection.execute(sql)

              rescue ActiveRecord::RecordNotUnique

                 puts "===================================================================="
                 puts "+--------------------------------------------"
                 puts "|THE MERCHANT - #{vendor_name.upcase} IS APPROVED ALREADY"
                 puts "+--------------------------------------------"
                 puts "===================================================================="

                 abort("ABORTING...")

              end

          else

            abort("TABLE "+table_name.upcase+" DOES NOT EXIST!!")

          end

    elsif answer == 'n'

      abort("MERCHANT "+vendor_name.upcase+" IS REJECTED!!")

    end

    orig_std_out = STDOUT.clone
    STDOUT.reopen(File.open(log_file_name, 'w+'))
    puts "-"
    puts "-"
    puts "-"
    puts "=============LOGIN DETAILS FOR "+vendor_name.upcase+"========================="
    puts "A merchant-"+vendor_name.capitalize+" has been added to CrawlFish db and enlisted in CrawlFish part-1 db on #{current_date}"
    puts "The following login details has been created for this vendor,"
    puts "+--------------------------------------------"
    puts "|AT         : "+current_date+"-"+current_time
    puts "|Login Name : "+login_name.downcase
    puts "|Password   : "+password.downcase
    puts "+--------------------------------------------"

    if type == "local"

      puts "+--------------------------------------------"
      puts "|Monetization Type : "+monetization_type.capitalize
      puts "|City Name         : "+city_name.capitalize
      puts "|Branch Name       : "+branch_name.capitalize
      puts "|Part-1 Table Name : "+table_name
      puts "|Business Type     : "+type.capitalize
      puts "|Vendor Id         : "+vendor_id.to_s
      puts "+--------------------------------------------"

  elsif type == "online"

      puts "+--------------------------------------------"
      puts "|Monetization Type : "+monetization_type.capitalize
      puts "|Part-1 Table Name : "+table_name
      puts "|Business Type     : "+type.capitalize
      puts "|Vendor Id         : "+vendor_id.to_s
      puts "+--------------------------------------------"

    end
    puts "===================================================================="
    STDOUT.reopen(orig_std_out)
    puts "===================================================================="
    puts "+--------------------------------------------"
    puts "|APPROVAL DETAILS WROTE TO #{log_file_name}"
    puts "+--------------------------------------------"
    puts "===================================================================="


  end


  def generate_login_name(vendor_name,city_name = "0",branch_name = "9")

    vendor_id = get_vendor_id(vendor_name.downcase,city_name.downcase,branch_name.downcase)

    login_name = "cf"+vendor_name[0]+city_name[0]+branch_name[0]+"x"+vendor_id.join

    login_name

  end

  def get_vendor_id(vendor_name,city_name,branch_name)

    sql = "SELECT vendor_id FROM vendors_lists WHERE vendor_name = '"+vendor_name+"' AND city_name = '"+city_name+"' AND branch_name = '"+branch_name+"'"

    vendor_id = ActiveRecord::Base.connection.execute(sql)

    vendor_id.map {|i| i }

  end

  def generate_random_password

    chars = ("a".."z").to_a + ("1".."9").to_a

    password = Array.new(8, '').collect{chars[rand(chars.size)]}.join

    password

  end

end


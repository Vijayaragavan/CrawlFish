class Handsaw < ActiveRecord::Base

  attr_accessor :filterdetails, :handsawHash

  def form_hand_saw_hash(keys)

      handsawHash = Hash.new{|hash, key| hash[key] = Array.new}

      (keys.length).downto(1) { |hashIndex|

        (hashIndex-1).downto(0){|arrayIndex|

          handsawHash[hashIndex] << keys.slice(keys.length-hashIndex..keys.length).slice(0..arrayIndex).join(" ")

        }

       }

       return handsawHash
  end

## The below code will be deprecated in the next release
  def startHashSearch(hashkey,v_handsawHash)

    handsawHash = Hash.new{|hash, key| hash[key] = Array.new}

    handsawHash = v_handsawHash

    flag = 0
    currentArraykey = 0

    if !(hashkey == 0)

      hashkey.downto(1) { |hashkey|

        (0).upto(hashkey-1) { |arraykey|
            firstletter = handsawHash[hashkey][arraykey][0]
            currentHashValue = handsawHash[hashkey][arraykey]

            begin

              if self.findbooks(firstletter,currentHashValue)

                 currentArraykey = arraykey
                 flag = 1

                 break

              end

            rescue SyntaxError, NameError

            end

         }

       if (flag == 1)

         self.startHashSearch(currentArraykey,handsawHash)

         break

       end

        }
     end

   end

    def findbooks(firstletter,v1_currentHashValue)

      @filterdetails = [ ]

    if firstletter == '0'
      modelname = "Zero"+"FiltersCollections"
    elsif firstletter == '1'
      modelname = "One"+"FiltersCollections"
    elsif firstletter == '2'
      modelname = "Two"+"FiltersCollections"
    elsif firstletter == '3'
      modelname = "Three"+"FiltersCollections"
    elsif firstletter == '4'
      modelname = "Four"+"FiltersCollections"
    elsif firstletter == '5'
      modelname = "Five"+"FiltersCollections"
    elsif firstletter == '6'
      modelname = "Six"+"FiltersCollections"
    elsif firstletter == '7'
      modelname = "Seven"+"FiltersCollections"
    elsif firstletter == '8'
      modelname = "Eight"+"FiltersCollections"
    elsif firstletter == '9'
      modelname = "Nine"+"FiltersCollections"
    else
      modelname = firstletter.upcase+"FiltersCollections"
    end

    currentfilterdetails = [ ]

    currentfilterdetails << modelname.constantize.find(:all,:select => ['filter_id', 'filter_table_name','filter_table_column'],:conditions => ['filter_key LIKE ?',"%#{v1_currentHashValue}%"])


    if !(currentfilterdetails.flatten.blank?)
       @filterdetails << currentfilterdetails.flatten
       return true

    else currentfilterdetails.flatten.blank?

      return false

    end

  end

   def fetchbooks(filterdetails,viewName)

        @bookslistid = [ ]

        id = [ ]
        table_name = [ ]
        column_name = [ ]
        filtersBookslistid = [ ]

        for i in (0..filterdetails.flatten.length-1)
        id << filterdetails.flatten[i].filter_id
        table_name << filterdetails.flatten[i].filter_table_name
        column_name << filterdetails.flatten[i].filter_table_column

        conditions = [[]]

        conditions[0] << column_name[i]
        conditions[0] << ' IN  ('
        conditions[0] << id[i]
        conditions[0] << ')'

        conditions[0] = conditions[0].join

        filtersBookslistid << table_name[i].constantize.find(:all, :select => 'books_list_id', :conditions => conditions[0])

        end

        if filtersBookslistid.empty?

          resultsFlag = 1
          return resultsFlag


        else

        self.joinSetBookslistsid(filtersBookslistid.flatten.map { |v| v.books_list_id.to_i })

        if !(@bookslistid.empty?)


          Search.createTempView(@bookslistid.flatten.map {|x| x},viewName)

          resultsFlag = 0
          return resultsFlag
           #self.renderCategoriesFilters(1)
        #@books =  BooksList.find(:all, :conditions => ["books_list_id IN (?)", @bookslistid[0].flatten.map { |v| v.to_i } ]).paginate(:per_page => 10, :page => params[:page])

        else

          #flash[:notice] = "No Results fetched for the search key entered!"
          #render ('shared/index')
          resultsFlag = 1
          return resultsFlag

        end

         end

    end

    def joinSetBookslistsid(filtersBookslistid)

    begin


    countHash = filtersBookslistid.flatten(1).inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    (countHash.values.max).downto(1)  { |i|
	     @bookslistid << countHash.select {|k,v| v == i}.keys
    }

    rescue SyntaxError, NoMethodError

      return

    end
  end

  def getBookslistid

    return @bookslistid

  end

  def getFilterdetails

    return @filterdetails

  end


end


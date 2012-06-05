module FilterHelper

  def form_filter_url(filter,params_filter_id,params_order,filter_name,filter_id,action,sub_category_id)
#form_filter_url(genre,params[:genre_id],params[:order],"genre_name","genre_id","filters",@sub_category_flag)



       if !(filter[1].downcase.gsub(/\./,"").gsub(/ /,"").chomp == "na")

         if filter[1].length > 1

           if !(params_order.nil?)

        	  if (params_filter_id.nil?)

        		  html = link_to (filter[1].capitalize+"["+filter[2].to_s+"]"), params.merge({:controller => 'filter', :action => action,:sub_category_id => sub_category_id,:view_name => @view_name, :query => params[:query], :from_pagination => 0, :order => params_order.to_i+1, filter_id.to_sym => (params_order.to_i+1).to_s+'>'+filter[0].to_s })

        		 else

        		  html = link_to (filter[1].capitalize+"["+filter[2].to_s+"]"), params.merge({:controller => 'filter', :action => action,:sub_category_id => sub_category_id,:view_name => @view_name,:query => params[:query], :from_pagination => 0,:order => params_order.to_i+1, filter_id.to_sym => params_filter_id.to_s+'|'+(params_order.to_i+1).to_s+'>'+filter[0].to_s })

        		 end

           else

             html = link_to (filter[1].capitalize+"["+filter[2].to_s+"]"), params.merge({:controller => 'filter', :action => action,:sub_category_id => sub_category_id,:view_name => @view_name,:query => params[:query],:from_pagination => 0,:order => 0, filter_id.to_sym => '0'+'>'+filter[0].to_s})

           end

          html

         end
       end

    end

    def form_cross_url(filter_id,params_filter_id,params_order,sub_category_id,tree_filter_id)

      #form_cross_url("binding_id",params[:binding_id],params[:order],@sub_category_flag,tree_filter_id)

       html = link_to ("x"), params.merge({:controller => 'filter', :action => 'cross_filters',:sub_category_id => sub_category_id,:from_pagination => 0,:view_name => @view_name,:query => params[:query], :order => params_order.to_i  , :tree_filter_id => tree_filter_id, filter_id.to_sym => params_filter_id.to_s, :filter_type => filter_id.to_s }), {:style => "color:#000; text-decoration:none"}

       html

    end

    def create_sub_category_box(sub_category_id)
#Commented out, it is to give links to the tree boxes
#<a href="" STYLE="text-decoration:none;">
         html =  '<span style="border:1px solid #CCC;position:relative;bottom:4px;background:#EEE;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;">

    		 <font color="#06C" >'

    		 html = html + @sub_categories.select{|i| i.sub_category_id == @sub_category_flag}.map {|i| i.category_name}.join.capitalize

    		 html = html + '</font>
    		 </span>'

    		 html + '<span style="color:#6E6A6B;size=2;position:relative;bottom:4px;background:#FFFFF;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;"></span>'
 		 end

 		 def style_tree_box(model_name,method_name,filter_type,tree_filter_id)
 		 # a lot of CSS should be implemented to shorten this method and follow good practices
 		    html =  '<span style="border:1px solid #CCC;position:relative;bottom:4px;background:#EEE;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;">

    		 <font color="#06C" >'

    		 html = html + model_name.constantize.send(method_name,tree_filter_id).join.titlecase
    		 html = html + '</font>
    		 </a>
    		 <span style="position:relative;bottom:1px;">'

    		 link = form_cross_url(filter_type,params[filter_type.to_sym],params[:order],@sub_category_flag,tree_filter_id)

    		 html = html + link

    		 html = html + '</span>
    		 </span>'

    		 html + '<span style="color:#6E6A6B;size=2;position:relative;bottom:4px;background:#FFFFF;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;"></span>'

  		 end

    def create_tree_box(tree_filter_id,param_type,params)

      if param_type == "genre_id"

        html = style_tree_box("BooksF2Genre","get_genre_names","genre_id",tree_filter_id)

      end

      if param_type == "binding_id"

       html = style_tree_box("BooksF5Binding","get_binding_names","binding_id",tree_filter_id)

      end

      if param_type == "publisher_id"

        html = style_tree_box("BooksF7Publisher","get_publishers","publisher_id",tree_filter_id)

      end

      if param_type == "language_id"

        html = style_tree_box("BooksF9Language","get_languages","language_id",tree_filter_id)

      end

      if param_type == "mobile_brand_id"

        html = style_tree_box("MobilesF1MobileBrand","get_mobile_brand_names","mobile_brand_id",tree_filter_id)

      end

      if param_type == "mobile_color_id"

        html = style_tree_box("MobilesF2MobileColor","get_mobile_color_names","mobile_color_id",tree_filter_id)

      end

      if param_type == "mobile_type_id"

        html = style_tree_box("MobilesF3MobileType","get_mobile_type_names","mobile_type_id",tree_filter_id)

      end

      if param_type == "mobile_design_id"

        html = style_tree_box("MobilesF4MobileDesign","get_mobile_design_names","mobile_design_id",tree_filter_id)

      end

      if param_type == "mobile_os_version_id"

        html = style_tree_box("MobilesF5OsVersion","get_mobile_os_versions","mobile_os_version_id",tree_filter_id)

      end

     if param_type == "primary_camera_id"

        html = style_tree_box("MobilesF9PrimaryCameras","get_primary_cameras","primary_camera_id",tree_filter_id)

      end

      if param_type == "secondary_camera_id"

        html = style_tree_box("MobilesF10SecondaryCameras","get_secondary_cameras","secondary_camera_id",tree_filter_id)

      end

      if param_type == "assorteds_id"

        html = style_tree_box("MobilesF15Assorteds","get_assorted_names","assorteds_id",tree_filter_id)

      end

      html

    end

    def parse_params(params,tree_flag = 0)

        big_params = Array.new

        params.keys.each do |i|

          if params[i] =~ /[0-9]>[0-9]/

                  temp_array = [ ]
                  temp_array = params[i].split("|")
                  final_big_param = Array.new
                  temp_array.each do |temp|
                          big_param = Hash.new

                          big_param[:filter_id] = i.to_s
                          big_param[:order] = temp.split(">")[0]
                          big_param[:id] = temp.split(">")[1]

                          if tree_flag == 0

                            big_param[:link_table_name] = set_link_table_name(i.to_s)

                          end

                          final_big_param << big_param
                  end
                  big_params << final_big_param.uniq {|e| e[:id] }

          end

        end

        big_params.flatten.sort_by {|i| i[:order].to_i}

    end

    def set_link_table_name(i)

      if i == "genre_id"
        "link_f2_books_lists"
      elsif i == "binding_id"
        "link_f5_books_lists"
      elsif i == "language_id"
        "link_f9_books_lists"
      elsif i == "publisher_id"
        "link_f7_books_lists"
      elsif i == "mobile_brand_id"
        "link_f1_mobiles_lists"
      elsif i == "mobile_color_id"
        "link_f2_mobiles_lists"
      elsif i == "mobile_type_id"
        "link_f3_mobiles_lists"
      elsif i == "mobile_design_id"
        "link_f4_mobiles_lists"
    elsif i == "mobile_os_version_id"
        "link_f5_mobiles_lists"
      elsif i == "primary_camera_id"
        "link_f9_mobiles_lists"
      elsif i == "secondary_camera_id"
        "link_f10_mobiles_lists"
      elsif i == "assorteds_id"
        "link_f15_mobiles_lists"
      end

    end
end


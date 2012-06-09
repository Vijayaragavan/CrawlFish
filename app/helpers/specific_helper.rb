module SpecificHelper

  def form_out_of_stock_links(type,display,link_name,include)

    if @area_id.nil?

        html = link_to (link_name.capitalize+" Out Of Stock") , {:controller => "availablility", :product_id => @product_id , :sub_category_id => @sub_category_id , :type => type, :include => include,:search_case => @search_case}
        html = '<div id="'+type+'-'+link_name+'-out-of-stock" style="display:'+display+';">' + html + '</div>'
        html

    elsif !@area_id.nil?

         html = link_to (link_name.capitalize+" Out Of Stock") , {:controller => "availablility", :product_id => @product_id , :sub_category_id => @sub_category_id , :type => type, :include => include, :area_id => @area_id,:search_case => @search_case}
        html = '<div id="'+type+'-'+link_name+'-out-of-stock" style="display:'+display+';">' + html + '</div>'
        html

    end

  end

end


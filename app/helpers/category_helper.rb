module CategoryHelper

# functions defined after this section are direct
#================ Direct Functions - START ================

  def decide_category_order(sub_category_id,index,sub_category_flag = 0)

    if sub_category_flag == 0

      self.set_html_class(index)

    else

      if sub_category_id == sub_category_flag

        self.set_html_class(0)

      else

         self.set_html_class(1)

      end

    end

    self.create_instance_variables(sub_category_id)

    self.set_count(sub_category_id)

    if !(@count.to_i == 0)

      self.set_and_return_html(sub_category_id)

    end

  end

  def form_clicked_category

    if !(@clicked_category.nil?)

      self.set_html_class(0)

      self.create_instance_variables(@sub_category_flag)

      self.create_instance_variables(@sub_category_flag)

      self.set_and_return_html(@sub_category_flag)

    end

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_and_return_html(sub_category_id)

    link_to (@sub_categories.select{|i| i.sub_category_id == sub_category_id }.map{|i| i.category_name}.join.capitalize+"["+@count.to_s+"]"), {:controller => 'category', :action => 'switch',:sub_category_id => sub_category_id, :query => params[:query], :view_name => @view_name, :search_case => @search_case },{:id => sub_category_id,:class => @html_class}

  end

  def create_instance_variables(sub_category_id)

    @sub_category_flag ||= sub_category_id

    @books_all_count ||= params[:books_all_count].to_i

    @mobiles_all_count ||= params[:mobiles_all_count].to_i

  end

  def set_html_class(index)

    if index == 0

      @html_class = "active_category"

    else

      @html_class = "inactive_category"

    end

  end

  def set_count(sub_category_id)

    @sub_categories.each do |i|

      if i.sub_category_id == sub_category_id

        if i.sub_category_name == "books_lists"

          @count = @books_all_count

        elsif i.sub_category_name == "mobiles_lists"

          @count = @mobiles_all_count

        end

      end

    end

  end

#================ Auxillary Functions - END ================

end


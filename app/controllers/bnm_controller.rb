class BnmController < ApplicationController
 #BNM stands for brick and mortar
 def show_areas

    if params[:id].present?
     @areas = Cities.where(:city_id => params[:id]).first.branches
    else
      @areas = []
    end

     render :partial => "specific/areas", :locals => { :areas => @areas }

  end

  def show_local_shops

     if params[:area_id].present? && params[:product_id].present? && params[:sub_category_id].present?

       set_sub_categories

       set_sub_category_name(params[:sub_category_id].to_i)

       set_excludable_availability_ids(1)

       self.set_page

       self.set_area

       @local_grids = LocalGridDetails.get_grid(params[:product_id].to_i,params[:sub_category_id].to_i,@excludable_availability_ids,params[:area_id].to_i).paginate(:per_page => 3, :page => @page)

       @local_grids_count = @local_grids.total_entries

     else

      @local_grids = [ ]

     end

    render :partial => "specific/local", :locals => { :local_grids => @local_grids, :product_id => params[:product_id], :sub_category_id => params[:sub_category_id], :area_id => params[:area_id]}

  end

  def set_page

    if params[:page].to_i == 0

      @page = 1

    else

      @page = params[:page].to_i

    end

  end

  def set_area

    if !(params[:area_id].to_i == 0)

      @area = Branches.where(:branch_id => params[:area_id].to_i).select("branch_name").map{|i| i.branch_name}[0]

    end

  end


end


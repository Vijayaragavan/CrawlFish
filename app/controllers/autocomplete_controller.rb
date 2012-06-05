class AutocompleteController < ApplicationController

  def show

    list = []

    search_key = params[:term].to_s

    search_key = search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq.join(" ")

    sphinx_search_key = "#{search_key}"

    titles = ProductsFilterCollections.search(sphinx_search_key, :match_mode => :extended).map &:filter_key

    titles.each {|i| list << {"label" => i}}

    respond_to do |format|
      format.json {render :json => list.to_json , :layout => false}
    end

  end

end


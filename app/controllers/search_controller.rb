class SearchController < ApplicationController
  respond_to :json, :only => [:index]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do

        @destinations = Destination.search(params[:q], params[:limit]) || []
        @places = Place.search(params[:q], params[:limit])             || []
        @people = Person.search(params[:q], params[:limit])            || []

        @all = (@places + @destinations + @people).flatten.compact

        render :json => @all.to_json 
      end
    end
  end

end

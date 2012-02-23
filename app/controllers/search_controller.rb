class SearchController < ApplicationController
  respond_to :json, :only => [:index]

  def index
    params[:limit] = params[:limit].try(:to_i) || 15

    @people       = Person.search(params[:q], params[:limit]).paginate(:page => params[:page], :per_page => 5)        || []
    @destinations = Destination.search(params[:q], params[:limit]).paginate(:page => params[:page], :per_page => 5)   || []
    @places       = Place.search(params[:q], params[:limit]).paginate(:page => params[:page], :per_page => 5)         || []


    respond_to do |format|
      format.html # index.html.erb

      format.json do
        entities = (@people + @destinations + @places).flatten.compact
        render :json => entities.to_json
      end
    end
  end

end



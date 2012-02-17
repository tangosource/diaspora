class SearchController < ApplicationController
  respond_to :json, :only => [:index]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do

        @destinations = Destination.search params[:q], params[:limit]
        @places = Place.search params[:q], params[:limit]
        @people = Person.search params[:q], params[:limit]        

        @all = []

        if @destinations.size > 0
          @destinations.each do |destination|
            @all.push(destination)
          end
        end

        if @places.size > 0
          @places.each do |place|
            @all.push(place)
          end
        end

        if @people.size > 0
          @people.each do |person|
            @all.push(person)
          end
        end

        render :json => @all.to_json 
      end
    end
  end

end

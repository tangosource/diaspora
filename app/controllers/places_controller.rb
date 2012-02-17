require File.join(Rails.root, "lib", 'stream', "place")

class PlacesController < ApplicationController

  respond_to :html, :only => [:show]
  respond_to :json, :only => [:index, :show, :get_place]


  # GET /places/1
  # GET /places/1.xml
  def show
    @stream = Stream::Place.new(current_user, params[:id], :max_time => max_time, :page => params[:page])

    respond_with do |format|
      format.json{ render_for_api :backbone, :json => @stream.stream_posts, :root => :posts }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new params[:place]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
    @tags_array = @place.tag_list.to_s
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])
    @place.tag_list = params[:place][:tag_list].gsub(/([\#]){1,}/,'');

    respond_to do |format|
      if @place.save
        format.html { redirect_to(@place, :notice => 'Place was successfully created.') }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])
    params[:place][:tag_list] = params[:place][:tag_list].gsub(/([\#]){1,}/,'');
    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to(@place, :notice => 'Place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def search
    respond_to do |format|
      format.json do
        @places = Place.search(params[:q]).limit(15)
        render :json => @people
      end
      format.html do
        places   = Place.search(params[:q], current_user)
        @places = places.paginate( :page => params[:page], :per_page => 15)
        render 'index'
      end
    end
  end

    def index
    respond_with do |format|
      format.json do
        @places = Place.search params[:q], params[:limit]
        render :json => @places.to_json 
      end
      format.html do
        @places = Place.all
      end
    end
  end

    def get_place
      respond_with do |format|
        place = Place.find(params[:id])
        format.html 
        format.json {render :json => place.to_json}
      end
    end

end

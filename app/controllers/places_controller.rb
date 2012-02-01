class PlacesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_authorized?, :only => :edit

  respond_to :html, :only => [:index, :show]
  respond_to :json, :only => [:index, :show]


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
    @tags = @place.tags
    @tags_array = []
    @tags.each do |obj| 
      @tags_array << { :name => ("#"+obj.name),
        :value => ("#"+obj.name)}
      end
    
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])

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

  private

  def user_authorized?
    if current_user.admin? == false
      flash[:notice] = 'You are not authorized to edit this place.'
      redirect_to root_path
    end
  end

end

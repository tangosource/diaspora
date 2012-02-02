class DestinationsController < ApplicationController
  respond_to :html, :only => [:index, :show]
  respond_to :json, :only => [:index, :show]

  helper :tags

  def index
    @destinations = Destination.all

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        @destinations = Destination.search params[:q], params[:limit]
        render :json => @destinations.to_json 
      end
    end
  end

  # GET /destinations/1
  # GET /destinations/1.xml
  def show
    if params[:id]
      @destination = Destination.find(params[:id]) 
    else
      @destination = Destination.where(:permalink => params[:permalink]).first
    end

    @stream = Stream::Destination.new(current_user, @destination.permalink, :max_time => max_time, :page => params[:page])

    respond_with do |format|
      format.json{ render_for_api :backbone, :json => @stream.stream_posts, :root => :posts }
    end
  end

  # GET /destinations/new
  # GET /destinations/new.xml
  def new
    @destination = Destination.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @destination }
    end
  end

  # GET /destinations/1/edit
  def edit
    @destination = Destination.find(params[:id])
  end

  # POST /destinations
  # POST /destinations.xml
  def create
    @destination = Destination.new(params[:destination])

    respond_to do |format|
      if @destination.save
        format.html { redirect_to(@destination, :notice => 'Destination was successfully created.') }
        format.xml  { render :xml => @destination, :status => :created, :location => @destination }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @destination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /destinations/1
  # PUT /destinations/1.xml
  def update
    @destination = Destination.find(params[:id])

    respond_to do |format|
      if @destination.update_attributes(params[:destination])
        format.html { redirect_to(@destination, :notice => 'Destination was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @destination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/1
  # DELETE /destinations/1.xml
  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy

    respond_to do |format|
      format.html { redirect_to(destinations_url) }
      format.xml  { head :ok }
    end
  end

  helper_method :tag_followed?

 def tag_followed?
   if @tag_followed.nil?
     @tag_followed = TagFollowing.joins(:tag).where(:tags => {:name => params[:name]}, :user_id => current_user.id).exists?
   end
   @tag_followed
 end
end

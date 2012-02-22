require File.join(Rails.root, "lib", 'stream', "destination")

class DestinationsController < ApplicationController
  respond_to :html, :only => [:index, :show]
  respond_to :json, :only => [:index, :show]

  before_filter :find_destination, :only=> [:show, :photos]
  before_filter :validates_user, :only  => [:edit]

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
    @stream = Stream::Destination.new(current_user, @destination.permalink, :title => @destination.title, :max_time => params[:max_time], 
                                      :page => params[:page], :names => @destination.name_list)

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
    @destination.tag_list = params[:destination][:tag_list].gsub(/([\#]){1,}/,'')
    @destination.name_list = params[:destination][:names].gsub(' ',', ') 
    @destination.permalink = params[:destination][:title]

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

    params[:destination][:tag_list] = params[:destination][:tag_list].gsub(/([\#]){1,}/,'');
    params[:destination][:name_list] = params[:destination][:name_list].gsub(' ',', ') 
    params[:destination][:permalink] = params[:destination][:title]

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

  def photos
    @stream = Stream::Destination::Photos.new(current_user, @destination.permalink, :max_time => params[:max_time], :page => params[:page])

    respond_with do |format|
      format.html {}
      format.json{ render_for_api :backbone, :json => @stream.stream_posts, :root => :posts }
    end
  end

  helper_method :tag_followed?

 def tag_followed?
   if @tag_followed.nil?
     @tag_followed = TagFollowing.joins(:tag).where(:tags => {:name => params[:name]}, :user_id => current_user.id).exists?
   end
   @tag_followed
 end

  def find_destination
    id = params[:id] || params[:destination_id]
    @destination = 
      Destination.find(id) || 
      Destination.where(:permalink => params[:permalink]).first
  end

  def search
    respond_to do |format|
      format.json do
        @destinations = Destination.search(params[:q]).limit(15)
        render :json => @people
      end
      format.html do
        destinations   = Destination.search(params[:q], current_user)
        @destinations = destinations.paginate( :page => params[:page], :per_page => 15)
        render 'index'
      end
    end
  end

  private
   def validates_user
     if !current_user or (current_user and !current_user.admin?)
       redirect_to :back, :notice => 'You need to be admin user to do that.'
     end
   end
end

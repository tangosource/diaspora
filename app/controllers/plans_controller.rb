class PlansController < ApplicationController
  before_filter :authenticate_user!, :only => :index
  before_filter :admin_user?, :only => :new

  def index
    @plans = Plan.all
    if current_user.subscription
      @subscription = current_user.subscription
    else
      @subscription = Plan.new.subscriptions.build
    end
  end

  def new
    @plan =  Plan.new
  end

  def create
    if Plan.create(params[:plan])
      redirect_to plans_path, :notice => 'Plan created successfuly.'
    else
      render :new, :notice => 'There was a problem when creating the plan.'
    end
  end

  private
  def admin_user?
    unless current_user.admin
      redirect_to :back, :notice => 'Only admin user is allowed to create plans.'
    end
  end

end

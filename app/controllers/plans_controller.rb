class PlansController < ApplicationController
  before_filter :authenticate_user!, :only => :index

  def index
    @plans = Plan.all
    if current_user.subscription
      @subscription = current_user.subscription
    else
      @subscription = Plan.new.subscriptions.build
    end
  end

end

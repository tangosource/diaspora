class PlansController < ApplicationController
  before_filter :authenticate_user!, :only => :index

  def index
    @plans = Plan.all
    @subscription = Plan.new.subscriptions.build
    @subscriptions = Subscription.user_subscriptions(current_user.id)
  end

end

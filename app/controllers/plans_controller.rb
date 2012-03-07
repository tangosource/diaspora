class PlansController < ApplicationController
  def index
    @plans = Plan.all
    @subscription = Plan.new.subscriptions.build
    @subscriptions = Subscription.user_subscriptions(current_user.id)
  end

end

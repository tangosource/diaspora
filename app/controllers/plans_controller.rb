class PlansController < ApplicationController
  def index
    @plans = Plan.all
    @subscriptions = Subscription.user_subscriptions(current_user.id)
  end

end

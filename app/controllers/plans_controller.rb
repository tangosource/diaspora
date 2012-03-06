class PlansController < ApplicationController
  def index
    @plans = Plan.all
    @subscriptions = Subscription.where :user_id => current_user.id
  end

end

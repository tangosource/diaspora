class SubscriptionsController < ApplicationController
  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    if @subscription.save!
      redirect_to subscriptions_path, :notice => 'Thank you for subscribing!'
    else
      render :new, :notice => 'There was a problem when creating your subscription, try it again please.'
    end
  end
end

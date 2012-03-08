class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :index]

  def index
    @plans = Plan.all
    if current_user.subscription
      @subscription = current_user.subscription
    else
      @subscription = Plan.new.subscriptions.build
    end
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    if @subscription.save_with_payment
      redirect_to plans_path, :notice => 'Thank you for subscribing!'
    else
      redirect_to plans_path, :notice => 'There was a problem when creating your subscription, try it again please.'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.delete_with_payment
    redirect_to plans_path
  end

end

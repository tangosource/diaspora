class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :index]

  def index
  end

  def new
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
      redirect_to subscriptions_path, :notice => 'Thank you for subscribing!'
    else
      redirect_to subscriptions_path, :notice => 'There was a problem when creating your subscription, try it again please.'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @plan = Plan.find(@subscription.plan_id)
    if @subscription.delete_with_payment
      redirect_to subscriptions_path, :notice => "You were unsuscribed from #{@plan.name} plan successfuly."
    else
      redirect_to subscriptions_path, :notice => 'There was a problem when deleting your subscription, try it again please.'
    end
  end

end

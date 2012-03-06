class SubscriptionsController < ApplicationController
  before_filter :validates_user_presence, :only => [:new, :create]

  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    debugger
    @subscription.user_id = current_user.id
    if @subscription.save_with_payment
      redirect_to subscriptions_path, :notice => 'Thank you for subscribing!'
    else
      render :new, :notice => 'There was a problem when creating your subscription, try it again please.'
    end
  end

  protected
  def validates_user_presence
    if current_user
      true
    else
      redirect :back
    end
  end
end

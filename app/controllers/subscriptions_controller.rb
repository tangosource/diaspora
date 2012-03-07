class SubscriptionsController < ApplicationController
  before_filter :authenticate_user1, :only => :create

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    if @subscription.save_with_payment
      redirect_to plans_path, :notice => 'Thank you for subscribing!'
    else
      render :new, :notice => 'There was a problem when creating your subscription, try it again please.'
    end
  end

end

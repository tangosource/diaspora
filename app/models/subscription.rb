class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  attr_accessor :stripe_card_token
  attr_accessor :email

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:description => email, :plan => plan_id, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
      debugger
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error when creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

  def self.user_subscriptions(user_id)
    where :user_id => user_id
  end

end

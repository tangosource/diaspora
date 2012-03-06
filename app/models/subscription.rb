class Subscription < ActiveRecord::Base
  belongs_to :user

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:description => current_user.email, :plan => plan_id, :card => stripe_card_token)
      stripe_customer_token = customer.id
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error when creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

end

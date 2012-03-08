class Plan < ActiveRecord::Base
  has_many :subscriptions

  validates_presence_of :name, :amount, :interval, :currency 
  validates_numericality_of :amount, :only_integer => true

  def save_in_stripe
    Stripe::Plan.create(
      :amount   => self.amount,
      :interval => self.interval,
      :name     => self.name,
      :currency => self.currency,
      :id       => self.stripe_id 
    )
    save!
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error when creating plan: #{e.message}"
      errors.add :base, "There was an error when creating the plan."
      false
  end
    
end

class Plan < ActiveRecord::Base
  has_many :subscriptions

  validates_presence_of :name, :amount, :interval, :currency 
  validates_numericality_of :amount, :only_integer => true

  def find_or_create
    plan = Stripe::Plan.retrieve(self.stripe_id)

    # Looks for the plan in the local DB and create it if don't exist
    unless Plan.find_by_stripe_id(plan.id)
      Plan.create(
        :stripe_id  => plan[:id],
        :name       => plan[:name],
        :interval   => plan[:interval],
        :amount     => plan[:amount],
        :currency   => plan[:currency]
      )
      return true
    else
      logger.error "Stripe error when creating plan: This plan already exists."
      errors.add :base, "There was an error when creating the plan:  This plan already exists."
      false
    end
    rescue Stripe::InvalidRequestError => e
      save_in_stripe
  end
    
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
      errors.add :base, "There was an error when creating the plan: #{e.message}"
      false
  end

  def to_dollars
    self.amount / 100
  end
end

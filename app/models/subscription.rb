class Subscription < ActiveRecord::Base
  belongs_to :user

  attr_accessor :stripe_card_token
end

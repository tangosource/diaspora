class Plan < ActiveRecord::Base
  has_many :subscriptions

  validates_presence_of :name, :amount, :interval, :currency 
    
end

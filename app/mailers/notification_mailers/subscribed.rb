module NotificationMailers
  class Subscribed < NotificationMailers::Base

    attr_accessor :recipient, :plan


    def set_headers(plan_id)
      @plan = Plan.find(plan_id)
      @headers[:to] = "aaron@gaytravelbuddy.com, anna@gaytravelbuddy.com"
      @headers[:subject] = @recipient.profile.first_name + " got suscribed to #{@plan.name} plan"
    end
  end
end

module NotificationMailers
  class Subscribed < NotificationMailers::Base

    def set_headers(plan_id)
      @plan = Plan.find(plan_id)
      @headers[:to] = "aaron+anna@gaytravelbuddy.com"
      @headers[:subject] = @recipient.profile.first_name + " got suscribed to #{@plan.name} plan"
    end
  end
end

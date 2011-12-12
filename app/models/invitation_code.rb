class InvitationCode < ActiveRecord::Base
  belongs_to :user
  before_create :generate_code

  def to_param
    title
  end

  def generate_code
    self.title =  ActiveSupport::SecureRandom.hex(6)
  end
end

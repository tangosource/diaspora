class InvitationCode < ActiveRecord::Base
  belongs_to :user
  before_create :generate_token

  def to_param
    token 
  end

  def generate_token
    self.token =  ActiveSupport::SecureRandom.hex(6)
  end
end

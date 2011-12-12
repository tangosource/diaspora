class InvitationCodesController < ApplicationController
  before_filter :ensure_valid_invite_code

  rescue_from ActiveRecord::NotFound do
    redirect_to root_url, :notice => "That invite code is no longer valid"
  end

  def show 
    redirect_to new_registration_path(:invite => {:code => params[:id]})
  end

  def ensure_valid_invite_code
    InvitationCode.find_by_code(params[:id])
  end
end

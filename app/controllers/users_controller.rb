class UsersController < ApplicationController

  def resend_confirmation_email
    p '--resend-confirmation--'*20
    render :nothing => true
  end

  def activate_user
    p '--lock-user--'*20
    render :nothing => true
  end

  def deactivate_user
    p '--unlock-user--'*20
    render :nothing => true
  end

end

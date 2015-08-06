class UsersController < ApplicationController

  def resend_confirmation_email
    user = User.find(params[:id])
    # Email confirmation with params[:message] to user[:email]
    render :nothing => true
  end

  def activate_user
    user = User.find(params[:id])
    user.update(active: true)
    render :nothing => true
  end

  def deactivate_user
    user = User.find(params[:id])
    user.update(active: false)
    # Email params[:message] to user[:email]
    render :nothing => true
  end

end

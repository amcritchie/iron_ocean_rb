class RootController < ApplicationController

  def routing
    if current_user
      dashboard
    else
      @user = User.new
      landing
    end
  end

  def landing
    @user = User.new
    render 'landing'
  end

  def dashboard
    @new_messages = Message.where(receiver_id: current_user, unread: true)
    render 'dashboard'
  end

  def contact
    AdminMailer.contact(params[:email], params[:message]).deliver
    render json: {error: "Email / password is invalid."}
  end

end

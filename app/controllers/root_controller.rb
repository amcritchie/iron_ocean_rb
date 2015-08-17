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

end

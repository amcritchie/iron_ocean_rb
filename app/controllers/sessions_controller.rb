class SessionsController < ApplicationController
  skip_before_filter :ensure_authenticated_user

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    session[:user_id] = @user.id
    if @user && @user[:admin]
      redirect_to admin_path
    else
      redirect_to :back
    end
  end

  def authenticate
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      # session[:user_id] = @user.id
      render json: @user
    else
      render json: {error: "Email / password is invalid."}
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
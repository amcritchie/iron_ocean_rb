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


  def new
    @user = User.new
  end

  # GET /messages/1/edit
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      # if @user.update(user_params)
      p '-='*100
      p user_params
      p '-='*100
      if current_user.update(user_params)
        p 'update'*100
        format.html { redirect_to @user, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        p 'edit'*100
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        # format.html { redirect_to @user, notice: 'Message was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :address, :city, :state, :zip_code, :phone_number, :image)
  end
end

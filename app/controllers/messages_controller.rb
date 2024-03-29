class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index

    @users_with_conversation = []
    @messages = Message.where(receiver_id: params[:user_id]).reverse_order
    @new_messages = @messages.where(unread: true)
    @messages.each do |message|
      unless @users_with_conversation.include?(message.sender)
        @users_with_conversation.push(message.sender)
      end
    end
    @messages = Message.all
  end

  def conversation
    @user = User.find(params[:user_id])
    @sender = User.find(params[:sender_id])

    received_messages = @user.received_messages.where(sender_id: @sender)
    received_messages.each do |message|
      message.update(unread: false)
    end


    @conversation = get_conversation(params[:user_id], params[:sender_id])

    @messages = Message.where(receiver_id: params[:user_id]).reverse_order
    @new_messages = @messages.where(unread: true)


    @users_with_conversation = []
  end

  def get_conversation(reader_id, sender_id)
    @user = User.find(reader_id)
    @sender = User.find(sender_id)
    sent_messages = @user.sent_messages.where(receiver_id: @sender)
    received_messages = @user.received_messages.where(sender_id: @sender)
    # Combines messages and orders them by created at.
    sent_messages.zip(received_messages).map{|h1,h2| h1.created_at > h2.created_at ? h1.merge(h2) : [h1 ,h2]}.flatten.reverse
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_id, :title, :body)
    end
end

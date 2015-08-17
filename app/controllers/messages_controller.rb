class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    # @messages = Message.all
    # @new_messages = [1,2,3]
    @new_messages = Message.where(receiver_id: params[:user_id], unread: true)
    # sql = "SELECT * FROM users"
    # ActiveRecord::Base.connection.execute(sql)
    #
    # p '-='*100
    # p ActiveRecord::Base.connection.execute(sql)
    # p '-='*100
    #
    # @connection = ActiveRecord::Base.connection
    # result = @connection.exec_query('SELECT * FROM users')
    # p '0'*40
    # p result.where(email: 'amcritchie@gmail.com')
    # result.each do |row|
    #   p '0'*40
    #   puts row
    # end

    @users_with_conversation = []
    # @last_messages = []

    @messages = Message.where(receiver_id: params[:user_id]).reverse_order
    p '123'*100
    @messages.each do |message|
      unless @users_with_conversation.include?(message.sender)
        @users_with_conversation.push(message.sender)
        # @last_messages.push(
        #     Message.where()
        # )
      end
    end
    p '_=-0-=_'*30
    p @users_with_conversation
    p '_=-0-=_'*30
    p @users_with_conversation.length
    p '_=-0-=_'*30
    @messages = Message.all
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

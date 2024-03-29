class BlogsController < ApplicationController
  # before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @blogs = Blog.all
    @articles = Article.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    puts '-'*100
    puts params
    puts params[:slug]
    puts '-'*100
    @blog = Blog.find_by(slug: params[:slug])
  end

  # GET /messages/new
  def new
    @blogs = Blog.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @blogs = Blog.new(message_params)

    respond_to do |format|
      if @blogs.save
        format.html { redirect_to @blogs, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @blogs }
      else
        format.html { render :new }
        format.json { render json: @blogs.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @blogs.update(message_params)
        format.html { redirect_to @blogs, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @blogs }
      else
        format.html { render :edit }
        format.json { render json: @blogs.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @blogs.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_message
  #   @blogs = Blog.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:message).permit(:sender_id, :receiver_id, :title, :body)
  end
end

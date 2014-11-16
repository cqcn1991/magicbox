# encoding: utf-8
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    if !params[:category].blank?
      @posts = Post.by_category(params[:category])
    #elsif params[:category] == 'card'
    #  @posts = Post.by_category('纸牌')
    #elsif params[:category] == 'mental'
    #  @posts = Post.by_category('心灵')
    else
      @posts = Post.order_by_date
    end

    if params[:sort] == 'like'
      @posts = @posts.order_by_likes
    elsif params[:sort] == 'reply'
      @posts = @posts.order_by_reply_number
    elsif params[:sort] == 'date'
      @posts = @posts.order_by_date
    end
    @posts = @posts.paginate(:page => params[:page])
  end

  def admin
    if params[:sort] == 'like'
      @posts = Post.order_by_likes
    elsif params[:sort] == 'reply'
      @posts = Post.order_by_reply_number
    else
      @posts = Post.order_by_date
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:url, :title, :source, :category, :abstraction)
    end
end

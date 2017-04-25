class PostsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :check_author, only: [:edit, :update, :destroy]
  def index
    if params[:sub_id]
      sub = Sub.find(params[:sub_id])
      @posts = sub.posts.all
    else
      @posts = Post.all
    end
    render :index
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    render :show
  end

  # GET /posts/new
  def new
    if params[:sub_id]
      sub = Sub.find(params[:sub_id])
      @post = sub.posts.new
      render :new
    else
      @post = Post.new
      render :new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_id, :user_id, sub_ids: [])
    end

    def check_author
      @post = Post.find(params[:id])
      redirect_to(sub_url(@post.sub)) unless @post.author == current_user
    end
end

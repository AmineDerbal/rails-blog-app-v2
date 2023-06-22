class PostsController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @current_user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

  def like
    @post = Post.find(params[:id])
    @user = current_user
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    @user_id = params[:user_id]
    @like.save
    redirect_to user_post_path(user_id: @user_id, id: params[:id])
  end

  def destroy
    @post = Post.find(params[:id])

    # Destroy all comments
    @post.comments.destroy_all if @post.comments.exists?
    # Destroy all likes
    @post.likes.destroy_all if @post.likes.exists?

    @post.destroy
    redirect_to user_posts_path(id: current_user.id)
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counters = 0

    if @post.save
      redirect_to user_posts_path, notice: 'Post created successfully'
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
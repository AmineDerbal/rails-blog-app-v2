class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @current_user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    @post.author_id = params[:user_id]
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

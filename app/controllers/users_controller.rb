class UsersController < ApplicationController
  layout 'standard'

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @first_three_posts = @user.posts.limit(3)
    @recent_posts = @user.recent_posts
  end
end

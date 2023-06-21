class UsersController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!
  ​
  def index
    @user = current_user
    @users = User.all
  end
  ​
  def show
    if params[:id] == 'sign_out'
      sign_out(current_user)
      redirect_to root_path, notice: 'You have been signed out successfully.'
    else
      @current_user = current_user
      @user = User.find(params[:id])
      @first_three_posts = @user.posts.limit(3)
      @recent_posts = @user.recent_posts
    end
  end
end

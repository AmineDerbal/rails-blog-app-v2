class UsersController < ApplicationController

  layout 'standard'

  def index
      @users = User.all
   end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
   end
end

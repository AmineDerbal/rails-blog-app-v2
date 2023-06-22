class Api::PostsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    posts = user.posts
    render json: posts
  end
end
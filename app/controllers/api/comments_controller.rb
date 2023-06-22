class Api::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    user = User.find_by(api_key: request.headers['X-Api-Key'])
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.author_id = user.id
    comment.post_id = post.id
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

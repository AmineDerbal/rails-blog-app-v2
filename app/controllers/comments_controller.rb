class Api::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
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
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

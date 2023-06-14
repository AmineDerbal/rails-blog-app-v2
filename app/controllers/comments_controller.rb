class CommentsController < ApplicationController
  layout 'standard'

  def new
    @comment = Comment.new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @author_id = params[:user_id]
    @post_id = params[:post_id]
    @comment.author_id = @author_id
    @comment.post_id = @post_id

    if @comment.save
      redirect_to user_post_path(user_id: @author_id, id: @post_id), notice: 'Commentcreated successfully'
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

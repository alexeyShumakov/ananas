class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  def create
    @like = Like.find_by(user: current_user, comment: @comment)
    if @like
      @comment = @like.comment
      @like.destroy
      render json: @comment, status: :ok
    else
      @like = Like.create(user: current_user, comment: @comment)
      render json: @like.comment, status: :created
    end
  end

  private

  def set_comment
    @comment = Comment.find(like_params[:comment_id])
  end
  def like_params
    params.require(:like).permit(:comment_id)
  end
end

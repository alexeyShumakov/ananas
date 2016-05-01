class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  after_action :verify_authorized, only: [:update, :destroy]

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = @comment.post

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render 'posts/show', alert: 'Comment was not created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @comment
    if @comment.update({body: params[:body]})
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    render json: { status: :deleted }, status: :ok
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end

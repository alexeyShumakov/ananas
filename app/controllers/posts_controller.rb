class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy, :update]
  before_action :set_categories, only: [:edit, :new, :create, :update]

  def show
    @comment = Comment.new
    @post.impressions += 1
    @post.save
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Good!'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was deleted.'
  end

  def update
    if @post.update post_params
      redirect_to @post
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.includes(:user, comments: [:user]).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:category_id, :title, :sinopsis, :avatar, :body)
  end

  def set_categories
    @categories = Category.all
  end
end

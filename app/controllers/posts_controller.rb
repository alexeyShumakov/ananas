class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy, :update]
  before_action :set_categories, only: [:edit, :new, :create, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  after_action :verify_authorized, only: [:new, :create, :edit, :update, :destroy]

  def show
    @comment = Comment.new
    @post.impressions += 1
    @post.save
  end

  def new
    authorize Post
    @post = Post.new
  end

  def edit
    authorize @post
  end

  def create
    authorize Post
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Good!'
    else
      render :edit
    end
  end

  def update
    authorize @post
    if @post.update post_params
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to root_path, notice: 'Post was deleted.'
  end

  def md_preview
    @text = { text: Kramdown::Document.new(params[:text]).to_html }
    render json: @text.to_json, status: :ok
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

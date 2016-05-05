class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_category!, only: [:new, :create, :edit, :update, :destroy]

  after_action :verify_authorized, only: [:new, :create, :edit, :update, :destroy]

  def newest
    @posts = Post.includes(:user, :category).order(created_at: :desc).page(params[:page])
  end

  def show
    @posts = @category.posts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to @category, notice: 'Good!'
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      redirect_to @category, notice: 'Good!'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: 'Deleted!'
  end

  private

  def authorize_category!
    authorize Category
  end
  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.includes(posts: [:user]).find(params[:id])
  end
end

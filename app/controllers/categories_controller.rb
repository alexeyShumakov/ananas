class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :update, :destroy]
  def newest
    @posts = Post.includes(:user, :category).first(10)
  end
  def show
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

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.includes(posts: [:user]).find(params[:id])
  end
end

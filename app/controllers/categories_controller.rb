class CategoriesController < ApplicationController
  def newest
    @posts = Post.includes(:user, :category).first(10)
  end
  def show
    @category = Category.includes(posts: [:user]).find(params[:id])
  end
end

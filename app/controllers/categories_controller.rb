class CategoriesController < ApplicationController
  def newest
    @posts = Post.last 10
  end
  def show
    @category = Category.find(params[:id])
  end
end

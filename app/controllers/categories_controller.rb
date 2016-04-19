class CategoriesController < ApplicationController
  def newest
    @posts = Post.first(10)
  end
  def show
    @category = Category.find(params[:id])
  end
end

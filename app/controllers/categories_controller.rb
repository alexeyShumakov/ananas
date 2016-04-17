class CategoriesController < ApplicationController
  def newest
    @categories = Category.last 10
  end
  def show
    @category = Category.find(params[:id])
  end
end

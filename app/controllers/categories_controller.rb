class CategoriesController < ApplicationController
  def newest
  end
  def show
    @category = Category.find(params[:id])
  end
end

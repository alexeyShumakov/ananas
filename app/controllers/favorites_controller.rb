class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @favorite = Favorite.find_by(user: current_user, post: @post)
    if @favorite
      @favorite.destroy
      @post.reload
      render json: @post, status: :ok
    else
      @favorite = Favorite.create(user: current_user, post: @post)
      render json: @favorite.post, status: :created
    end
  end

  private

  def set_post
    @post = Post.find(like_params[:post_id])
  end
  def like_params
    params.require(:favorite).permit(:post_id)
  end
end

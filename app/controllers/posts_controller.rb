class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destoy, :update]
  def show
    @comment = Comment.new
    @post.impressions += 1
    @post.save
  end

  def edit
  end

  def new
  end

  def destroy
  end

  def update
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end

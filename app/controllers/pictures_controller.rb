class PicturesController < ApplicationController
  before_action :authenticate_user!
  def create
    @picture = Picture.new(image: params[:image])
    if @picture.save
      render json: @picture, status: :ok
    else
      render json: @picture.errors, status: :unprocessable_entity
    end
  end
end

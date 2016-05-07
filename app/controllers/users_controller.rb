class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:update]

  def private_office
  end

  def search
    authorize User 
    @users = User.search_by_email(params[:keyword])
    render json: @users, status: :ok
  end

  def update
    authorize @user
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def profile
    if current_user.update(self_user_params)
      render json: current_user, status: :ok
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def self_user_params
    params.require(:user).permit(:email, :username, :avatar)
  end

  def user_params
    params.require(:user).permit(:email, :username, :role, :avatar)
  end
end

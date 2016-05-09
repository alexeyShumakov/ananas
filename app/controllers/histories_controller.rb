class HistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  def index
    @histories = History.all.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @history = History.new
  end

  def edit
    authorize @history
  end

  def create
    @history = History.new(history_params)
    @history.user = current_user

      if @history.save
        redirect_to @history, notice: 'History was successfully created.'
      else
        render :new
      end
  end

  def update
      authorize @history
      if @history.update(history_params)
        redirect_to @history, notice: 'History was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    authorize History
    @history.destroy
    redirect_to histories_url, notice: 'History was successfully destroyed.'
  end

  private

  def set_history
    @history = History.find(params[:id])
  end

  def history_params
    params.require(:history).permit(:title, :history)
  end
end

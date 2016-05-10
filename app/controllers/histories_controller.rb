class HistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  def index
    @histories = History.where(moderated: true).order(created_at: :desc).page(params[:page])
  end

  def show
    if @history.moderated
      @history.impressions += 1
      @history.save
    else
      redirect_to root_path
    end
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
      respond_to do |format|
        if @history.update(permitted_attributes(@history))
          format.json { render json: @history }
          format.html { redirect_to  private_office_path }
        else
          format.json { render json: @history.errors, status: :unprocessable_entity }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    authorize History
    @history.destroy
    respond_to do |format|
      format.json { render json: {status: 'ok'} }
      format.html { redirect_to private_office_path }
    end
  end

  private

  def set_history
    @history = History.find(params[:id])
  end

  def history_params
    params.require(:history).permit(:title, :history)
  end
end

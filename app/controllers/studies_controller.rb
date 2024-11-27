class StudiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :destroy]
  def index
    if user_signed_in?
      @studies = current_user.studies.left_joins(:recalls)
                      .select("studies.*, MIN(recalls.recall_date) AS next_recall_date")
                      .group("studies.id")
                      .order(Arel.sql("CASE 
                        WHEN MIN(recalls.recall_date) IS NULL THEN 1
                        WHEN MIN(recalls.recall_date) <= CURRENT_DATE THEN 0 
                        ELSE 2 
                      END, created_at DESC"))
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @study = Study.new
  end

  def create
    @study = current_user.studies.new(study_params)
    if @study.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @study.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @study.update(study_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @recall = @study.recalls.where(completed: false).order(:recall_date).first
  end

  private

  def set_study
    @study = Study.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless @study.user_id == current_user.id
  end
  def study_params
    params.require(:study).permit(:title, :content, :image).merge(user_id: current_user.id)
  end
end

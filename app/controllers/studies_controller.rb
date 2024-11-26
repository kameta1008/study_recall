class StudiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  def index
    @studies = Study.left_joins(:recalls)
                    .select("studies.*, MIN(recalls.recall_date) AS next_recall_date")
                    .group("studies.id")
                    .order(Arel.sql("CASE 
                      WHEN MIN(recalls.recall_date) IS NULL THEN 1
                      WHEN MIN(recalls.recall_date) <= CURRENT_DATE THEN 0 
                      ELSE 2 
                    END, created_at DESC"))
  end

  def new
    @study = Study.new
  end

  def create
    @study = Study.new(study_params)
    if @study.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    study = Study.find(params[:id])
    study.destroy
    redirect_to root_path
  end

  def edit
    @study = Study.find(params[:id])
  end

  def update
    @study = Study.find(params[:id])
    if @study.update(study_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @study = Study.find(params[:id])
    @recall = @study.recalls.where(completed: false).order(:recall_date).first
  end

  private
  def study_params
    params.require(:study).permit(:title, :content, :image).merge(user_id: current_user.id)
  end
end

class StudiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  def index
    @studies = Study.order('created_at DESC')
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

  private
  def study_params
    params.require(:study).permit(:title, :content, :image).merge(user_id: current_user.id)
  end
end

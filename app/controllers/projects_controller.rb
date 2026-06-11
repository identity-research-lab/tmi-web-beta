class ProjectsController < ApplicationController

  def index
    @project = Project.last
    @project ||= Project.create
    @case_count = Persona.count
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.last
    @project ||= Project.new
    @project.csv_data = project_params[:csv_data].read
    if @project.save
      redirect_to project_path(@project)
    else
      #TODO handle error
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    if csv_param[:csv_data].present?
      @project.update!(csv_data: csv_param[:csv_data].read)
      @project.create_survey_items_from_csv
    end
    @project.update!(project_params)
    redirect_to edit_project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :researcher)
  end

  def csv_param
    params.require(:project).permit(:csv_data)
  end

end

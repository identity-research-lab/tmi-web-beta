class ProjectsController < ApplicationController

  def index
    @project = Project.last
    @project ||= Project.new
    @case_count = Persona.count
  end
  
  def show
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
  
  private
  
  def project_params
    params.require(:project).permit(:name, :description, :researcher, :csv_data)
  end

end
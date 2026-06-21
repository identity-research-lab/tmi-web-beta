class PersonasController < ApplicationController

  def index
    @personas = Persona.all
    @project = Project.last
    @case_count = Persona.count
    @uncoded_case_count = Persona.uncoded.count
    @in_progress_case_count = Persona.in_progress.count
    @completed_case_count = Persona.completed.count
    @code_count = CodedExperience.count
  end

  def show
  end

  def edit
  end

  def update
  #   @project = Project.find(params[:id])
  #   if project_params[:csv_data].present?
  #     @project.update!(csv_data: String.new(project_params[:csv_data].read, encoding: 'UTF-8'))
  #     @project.create_survey_items_from_csv
  #   elsif project_params[:refresh_started_at].present?
  #     @project.create_survey_responses_from_csv
  #   else
  #     @project.update!(project_params)
  #   end
  #   redirect_to edit_project_path(@project)
  end

  private

#   def project_params
#     params.require(:project).permit(:name, :description, :researcher, :csv_data, :refresh_started_at)
#   end

end

class ProjectsController < ApplicationController

  def index
    @project = Project.last
    @project ||= Project.create
    @case_count = Persona.count
    @survey_item_count = SurveyItem.count
    @survey_response_count = SurveyResponse.count
    @code_count = CodedExperience.count
    @category_count = Category.count
    @theme_count = Theme.count
    @memo_count = Memo.count
    @recent_memos = Memo.all.order(created_at: :desc).limit(4)
    @recent_events = Event.all.order(created_at: :desc).limit(4)
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
    @project.csv_data = String.new(project_params[:csv_data].read, encoding: 'UTF-8')
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
      @project.update!(csv_data: String.new(csv_param[:csv_data].read, encoding: 'UTF-8'))
      @project.create_survey_items_from_csv
    end
    if refresh_param[:refresh_started_at].present?
      @project.create_survey_responses_from_csv
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

  def refresh_param
    params.require(:project).permit(:refresh_started_at)
  end

end

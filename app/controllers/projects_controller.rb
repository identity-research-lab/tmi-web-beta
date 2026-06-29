class ProjectsController < ApplicationController

  def index
    @project = Project.last
    @project ||= Project.create
    @case_count = Persona.count
    @uncoded_case_count = Persona.uncoded.count
    @in_progress_case_count = Persona.in_progress.count
    @completed_case_count = Persona.completed.count
    @survey_item_count = SurveyItem.count
    @survey_response_count = SurveyResponse.count
    @survey_response_coded_count = SurveyResponse.coded.count
    @code_count = Code.count
    @category_count = Category.count
    @theme_count = Theme.count
    @memo_count = Memo.count
    @memos = Array.new(Memo.all.limit(4))#.order(created_at: :desc).limit(4)
    @recent_events = Event.all.order(created_at: :desc).limit(4)
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @dimensions_for_select = Dimension.all.order(:name)
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
    if project_params[:csv_data].present?
      @project.update!(csv_data: String.new(project_params[:csv_data].read, encoding: 'UTF-8'))
      @project.create_survey_items_from_csv
    elsif project_params[:refresh_started_at].present?
      @project.create_survey_responses_from_csv
    else
      @project.update!(project_params)
    end
    redirect_to edit_project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :researcher, :csv_data, :refresh_started_at)
  end

end

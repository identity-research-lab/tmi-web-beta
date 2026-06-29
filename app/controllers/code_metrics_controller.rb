class CodeMetricsController < ApplicationController
  
  def index
    @project = Project.last
    @survey_items = SurveyItem.active.order(:identifier)
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
  end
  
  def create
    @survey_items = SurveyItem.active.order(:identifier)
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("survey-item-codes", partial: "/code_metrics/show", locals: { survey_item: @survey_item, survey_items: @survey_items })
      end
    end
  end
  
end
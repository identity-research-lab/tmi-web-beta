class CodeMetricsController < ApplicationController
  
  def index
    @project = Project.last
    @survey_items = @project.active_fields.all.sort{|a,b| a.formatted_identifier <=> b.formatted_identifier }
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
  end
  
  def create
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("survey-item-codes", partial: "/code_metrics/show", locals: { survey_item: @survey_item })
      end
    end
  end
  
end
class CodeMetricsController < ApplicationController
  
  def index
    @survey_items = SurveyItem.active.order(:identifier)
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
    @personas = Persona.order(:identifier)
    @persona = params[:persona_id] && Persona.find(params[:persona_id])
  end
  
  def create
    @survey_items = SurveyItem.active.order(:identifier)
    @survey_item = params[:survey_item_id] && SurveyItem.find(params[:survey_item_id])
    @personas = Persona.order(:identifier)
    @persona = params[:persona_id] && Persona.find(params[:persona_id])
    respond_to do |format|
      format.turbo_stream do
        if params[:survey_item_id]
          render turbo_stream: turbo_stream.replace("survey-item-codes", partial: "/code_metrics/question", locals: { survey_item: @survey_item, survey_items: @survey_items })
        elsif params[:persona_id]
          render turbo_stream: turbo_stream.replace("persona-codes", partial: "/code_metrics/persona", locals: { persona: @persona, personas: @personas })
        end
      end
    end
  end
  
end
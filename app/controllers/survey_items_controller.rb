class SurveyItemsController < ApplicationController
  
  def update
    @survey_item = SurveyItem.find(params[:id])
    success = @survey_item.update(survey_item_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("frame-survey-item-#{@survey_item.id}", partial: "/survey_items/form", locals: { survey_item: @survey_item, success: success })
      end
    end
  end
  
  private
  
  def survey_item_params
    params.require(:survey_item).permit(:prompt, :label, :item_kind, :is_active, :dimension_id)
  end
  
end


class SurveyItemsController < ApplicationController
  
  def update
    
  end
  
  private
  
  def survey_item_params
    params.require(:survey_item).permit(:prompt, :label, :item_kind, :is_ignored)
  end
  
end


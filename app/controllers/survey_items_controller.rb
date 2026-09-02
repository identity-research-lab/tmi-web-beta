class SurveyItemsController < ApplicationController

  def index
#    @personas = Persona.as(:persona).query.optional_match('(persona)-[]-()-[]-(c:Code)').return('persona,count(c)').order('persona.identifier')

    @survey_items = SurveyItem.active.order(:identifier)
    @question_count = @survey_items.count
    @responses_count = SurveyResponse.count
    @identities_count = SurveyResponse.identities.count
    @coded_experiences_count = Code.count
  end

  def show
    @survey_item = SurveyItem.find(params[:id])
    @survey_responses = @survey_item.survey_responses.sort{|a,b| a.persona.formatted_identifier <=> b.persona.formatted_identifier}
    @memos = @survey_item.memos.order(created_at: :desc)
    @memo = Memo.new(kind: "survey_item", referrent_id: @survey_item.id)
    @coded_experiences_count = @survey_item.code_count

    # TODO categories
    @categories_count = 0
    @categories = []
  end

  def update
    @survey_item = SurveyItem.find(params[:id])
    success = @survey_item.update(survey_item_params)
    return
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("frame-survey-item-#{@survey_item.id}", partial: "/survey_items/form", locals: { survey_item: @survey_item, success: success })
      end
    end
  end

  private

  def survey_item_params
    params.require(:survey_item).permit(:prompt, :name, :item_kind, :is_active, :dimension_id)
  end

end

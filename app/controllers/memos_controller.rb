class MemosController < ApplicationController

  def create
    success = Memo.create(params[:memo_params])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("frame-memo-form", partial: "/memo/form", locals: { 
          memo: Memo.new(
            persona_id: memo_params[:persona_id],
            code_id: memo_params[:code_id],
            project_id: memo_params[:project_id],
            survey_item_id: memo_params[:survey_item_id],
            survey_response_id: memo_params[:survey_response_id]
          ), success: success 
        })
      end
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:persona_id, :code_id, :survey_item_id, :survey_response_id, :project_id)
  end

end

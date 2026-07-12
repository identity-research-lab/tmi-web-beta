class CodesController < ApplicationController
  
  def create
    @code = Code.new(label: code_params[:label])
    if @survey_response = SurveyResponse.find(code_params[:survey_response])
      @code.survey_responses << @survey_response
      @code.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("codes-for-#{@survey_response.id}"), partial: "/codes/show", locals: { survey_response: @survey_response }
        end
      end
    end
  end
  
  def destroy
    @code = Code.find(params[:id])
    if @survey_response = SurveyResponse.find(code_params[:survey_response])
      @code.detach_from(@survey_response)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("codes-for-#{@survey_response.id}"), partial: "/codes/show", locals: { survey_response: @survey_response }
        end
      end
    end
  end

  private
  
  def code_params
    params.require(:code).permit(:label, :survey_response)
  end
  
end
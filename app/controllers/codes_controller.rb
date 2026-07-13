class CodesController < ApplicationController
  
  def create
    if @survey_response = SurveyResponse.find(code_params[:survey_response])
      @persona = @survey_response.persona
      @persona.coded!
      @code = Code.find_or_create_by(label: code_params[:label], dimension: @survey_response.dimension.name)
      @code.survey_responses << @survey_response unless @code.survey_responses.include? @survey_response
      @code.personas << @persona unless @code.personas.include? @persona
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("codes-for-#{@survey_response.id}", partial: "/codes/show", locals: { survey_response: @survey_response })
        end
      end
    end
  end
  
  def update
    @code = Code.find(params[:id])
    if @survey_response = SurveyResponse.find(code_params[:survey_response])
      @code.detach_from(@survey_response)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("codes-for-#{@survey_response.id}", partial: "/codes/show", locals: { survey_response: @survey_response })
        end
      end
    end
  end

  private
  
  def code_params
    params.require(:code).permit(:label, :survey_response)
  end
  
end
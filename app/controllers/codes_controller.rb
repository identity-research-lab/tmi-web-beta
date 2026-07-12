class CodesController < ApplicationController
  
  def create
    @code = Code.new(name: code_params[:code_name])
    if @survey_response = SurveyResponse.find(code_params[:survey_response])
      @code.personas << @survey_response.persona
      @code.survey_responses << @survey_response
      @code.save
    end
  end
  
  private
  
  def code_params
    params.require[:code].permit(:code_name, :survey_response)
  end
  
end
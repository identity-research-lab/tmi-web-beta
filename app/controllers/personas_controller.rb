class PersonasController < ApplicationController

  def index
    @personas = Persona.as(:persona).query.optional_match('(persona)-[]-(:SurveyResponse)-[]-(c:Code)').return('persona,count(c)').order('persona.identifier')
    @case_count = Persona.count
    @uncoded_case_count = Persona.uncoded.count
    @in_progress_case_count = Persona.in_progress.count
    @completed_case_count = Persona.completed.count
    @code_count = Code.count
    @last_active_code = Code.all.order(:updated_at).limit(1).first
    @last_activity = [@last_active_code && @last_active_code.updated_at || @project.updated_at, @project.updated_at].sort.last
  end

  def show
    @persona = Persona.find(params[:id])
    @active_survey_items = @project.active_fields
    @survey_responses = @persona.survey_responses.as(:sr).query.match("(sr)-[]-(si:SurveyItem)").order("si.identifier").return(:sr).pluck(:sr)
    @coded_experiences_count = @persona.experiences.count
    @categories = []
    @memos = @persona.memos.order(created_at: :desc)
    @memo = Memo.new(kind: "persona", referrent_id: @persona.id)
  end

  def edit
  end

  def update
    @persona = Persona.find(params[:id])
    @persona.complete! if params[:complete] == "complete"
    redirect_to @persona
  end

end

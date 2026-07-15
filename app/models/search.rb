class Search
  
  include ActiveModel::API
  
  attr_accessor :query
  
  def initialize(query)
    self.query = query
  end

  def results
    return [] unless self.query.present?
    @results ||= { responses: response_results, codes: code_results, memos: memo_results, personas: persona_results }
  end
  
  def code_results
    return [] unless self.query.present?
    @code_results ||= Code.as(:c).where("toLower(c.label) CONTAINS toLower($text)", text: self.query)
  end

  def memo_results
    return [] unless self.query.present?
    @memo_results ||= Memo.as(:m).where("toLower(m.text) CONTAINS toLower($text)", text: self.query)
  end
  
  def persona_results
    return [] unless self.query.present?
    @persona_results ||= Persona.as(:p).where("p.participant_id = $text OR p.identifier = $text", text: self.query)
  end
  
  def response_results
    return [] unless self.query.present?
    @response_results ||= SurveyResponse.as(:r).where("toLower(r.value) CONTAINS toLower($text)", text: self.query)
  end
  
end
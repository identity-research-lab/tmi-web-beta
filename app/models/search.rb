class Search
  
  include ActiveModel::API
  
  attr_accessor :query
  attr_accessor :scope  

  SCOPES = %w{ category code memo theme theme }
  
  def initialize(params)
    self.query = params[:query]
    self.scope = params[:scope] if SCOPES.include? params[:scope]
  end

  def results
    return [] unless self.query.present?
    return @results if @results
    if self.scope.present?
      case self.scope
      when "category" 
        @results = category_results
      when "code"
        @results = code_results
      when "memo"
        @results = memo_results
      when "response"
        @results = response_results
      when "theme"
        @results = theme_results
      end
    else
      @results = { categories: category_results, codes: code_results, memos: memo_results, responses: response_results }
    end
  end
  
  def category_results
    return [] unless self.query.present?
    @category_results ||= Category.as(:c).where("toLower(c.name) CONTAINS toLower($text) OR toLower(c.description) CONTAINS toLower($text)", text: self.query)
  end
  
  def code_results
    return [] unless self.query.present?
    @code_results ||= Code.as(:c).where("toLower(c.name) CONTAINS toLower($text)", text: self.query)
  end

  def memo_results
    return [] unless self.query.present?
    @memo_results ||= Memo.as(:m).where("toLower(m.text) CONTAINS toLower($text)", text: self.query)
  end
  
  def response_results
    return [] unless self.query.present?
    @response_results ||= SurveyResponse.as(:r).where("toLower(r.value) CONTAINS toLower($text)", text: self.query)
  end
  
  def theme_results
    return [] unless self.query.present?
    @theme_results ||= Theme.as(:t).where("toLower(t.name) CONTAINS toLower($text)", text: self.query)
  end
  
end
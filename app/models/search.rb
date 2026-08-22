class Search
  
  include ActiveModel::API
  
  attr_accessor :query
  attr_accessor :scope  

  SCOPES = %w{ category code memo theme theme }
  
  def initialize(params)
    self.query = params[:query]
    if params[:scope] && SCOPES.include? params[:scope]
      self.scope = params[:scope]
    else
      self.scope = "all"
    end
  end

  def results
    return [] unless self.query.present?
    @results ||= { categories: category_results, codes: code_results, memos: memo_results, responses: response_results }
  end
  
  private
  
  def category_results
    return [] unless self.scope == "all" || self.scope == "category"
    @category_results ||= Category.as(:c).where("toLower(c.name) CONTAINS toLower($text) OR toLower(c.description) CONTAINS toLower($text)", text: self.query)
  end
  
  def code_results
    return [] unless self.scope == "all" || self.scope == "code"
    @code_results ||= Code.as(:c).where("toLower(c.name) CONTAINS toLower($text)", text: self.query)
  end

  def memo_results
    return [] unless self.scope == "all" || self.scope == "memo"
    @memo_results ||= Memo.as(:m).where("toLower(m.text) CONTAINS toLower($text)", text: self.query)
  end
  
  def response_results
    return [] unless self.scope == "all" || self.scope == "response"
    @response_results ||= SurveyResponse.as(:r).where("toLower(r.value) CONTAINS toLower($text)", text: self.query)
  end
  
  def theme_results
    return [] unless self.scope == "all" || self.scope == "theme"
    @theme_results ||= Theme.as(:t).where("toLower(c.name) CONTAINS toLower($text) OR toLower(c.description) CONTAINS toLower($text)", text: self.query)
  end
  
end
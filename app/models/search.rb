class Search
  
  include ActiveModel::API
  
  attr_accessor :query
  attr_accessor :scope  
  attr_accessor :limit
  attr_accessor :per_page
  attr_accessor :offset
  
  SCOPES = %w{ all category code memo theme theme }
  
  def initialize(query:, limit: 1000, per_page: 10, offset: 0, scope: [])
    self.query = query.to_s
    self.limit = limit.to_i
    self.per_page = per_page.to_i
    self.offset = offset.to_i
    self.scope = [scope].flatten.compact
    self.scope = ["all"] if self.scope.empty?
  end

  def results
    return [] unless self.query.present?
    @results ||= { categories: category_results, codes: code_results, memos: memo_results, responses: response_results }
  end
  
  def category_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("category")
    @category_results ||= Category.all if self.query == "*"
    @category_results ||= Category.as(:c).where("toLower(c.name) CONTAINS toLower($text) OR toLower(c.description) CONTAINS toLower($text)", text: self.query)
  end
  
  def code_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("code")
    @code_results ||= Code.as(:c).query.match("(c)-[]-(:SurveyResponse)").where("toLower(c.name) CONTAINS toLower($text)", text: self.query).return("DISTINCT c").order("c.name").limit(self.limit).map{|r| r[:c]}
  end

  def memo_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("memo")
    @memo_results ||= Memo.as(:m).where("toLower(m.text) CONTAINS toLower($text)", text: self.query)
  end
  
  def response_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("response")
    @response_results ||= SurveyResponse.as(:r).where("toLower(r.value) CONTAINS toLower($text)", text: self.query)
  end
  
  def theme_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("theme")
    @theme_results ||= Theme.as(:t).where("toLower(t.name) CONTAINS toLower($text) OR toLower(t.description) CONTAINS toLower($text)", text: self.query)
  end
  
end
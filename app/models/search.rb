class Search
  
  include ActiveModel::API
  
  attr_accessor :query
  attr_accessor :scope  
  attr_accessor :limit
  attr_accessor :per_page
  attr_accessor :offset
  attr_accessor :sort_key
  attr_accessor :sort_dir
    
  SCOPES = %w{ all category code memo response theme }
  
  def initialize(query:, limit: 1000, per_page: 10, offset: 0, sort_key: "name", sort_dir: "ASC", scope: [])
    self.query = query.to_s
    self.limit = limit.to_i
    self.per_page = per_page.to_i
    self.offset = offset.to_i
    self.sort_key = %w{name frequency created_at updated_at}.include?(sort_key) ? sort_key : "name"
    self.sort_dir = %w{ASC DESC}.include?(sort_dir.to_s.upcase) ? sort_dir.to_s.upcase : "ASC"
    self.scope = [scope].flatten.compact
    self.scope = ["all"] if self.scope.empty?
  end

  def results
    @results ||= { categories: category_results, codes: code_results, memos: memo_results, responses: response_results }
  end

  # one-dimensional  
  def paged_results
    results.values.flatten[self.offset..(self.offset + self.per_page - 1)]
  end
  
  def total_results
    results.values.flatten.count    
  end
  
  def category_results
    return [] unless self.query.present?
    return [] unless self.scope.include?("all") || self.scope.include?("category")
    @category_results ||= Category.all if self.query == "*"
    @category_results ||= Category.as(:c).where("toLower(c.name) CONTAINS toLower($text) OR toLower(c.description) CONTAINS toLower($text)", text: self.query)
  end
  
  def code_results
    return @code_results if @code_results
    
    if self.sort_key == "frequency"
      @code_results ||= Code.as(:c).query.match("(c)-[]-(sr:SurveyResponse)").with("c, COUNT(sr) AS ct").where("toLower(c.name) CONTAINS toLower($text)", text: self.query).return("DISTINCT c").order("ct #{self.sort_dir}").limit(self.limit).map{|r| r[:c]}
    else
      @code_results ||= Code.as(:c).query.match("(c)-[]-(:SurveyResponse)").where("toLower(c.name) CONTAINS toLower($text)", text: self.query).return("DISTINCT c").order("c.#{self.sort_key} #{self.sort_dir}").limit(self.limit).map{|r| r[:c]}
    end
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
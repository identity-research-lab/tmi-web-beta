class Code
  include ActiveGraph::Node

  attr_accessor :action

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize
  validates :name, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :name
  
  has_many :in, :categories, type: :Contains, model_class: "Category"
  has_many :in, :survey_responses, type: :AssociatedWith, model_class: "SurveyResponse"
  has_many :out, :dimensions, type: :RelatesTo, model_class: "Dimension"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_one :out, :researcher, type: :CodesAs, model_class: "Researcher"

  def self.applied(limit=nil)
    if limit
      Code.as(:c).query.match("(c)-[]-(:SurveyResponse)").return("DISTINCT c").order("c.name").limit(limit).map{|r| r[:c]}
    else
      Code.as(:c).query.match("(c)-[]-(:SurveyResponse)").return("DISTINCT c").order("c.name").map{|r| r[:c]}
    end
  end

  def self.categorized
    Code.as(:c).query.match("(c)-[:Contains]-(:Category)").return("DISTINCT c").uniq.map{|r| r[:c]}
  end

  def self.categorized_count
    Code.as(:c).query.match("(c)-[:Contains]-(:Category)").return("COUNT(DISTINCT c) AS ct").uniq.map{|c| c[:ct]}.first
  end
  
  def self.uncategorized
    Code.as(:c).query.where("NOT EXISTS { (c)-[:Contains]-(:Category) }").return(:c).map{|r| r[:c]}
  end

  def self.uncategorized_count
    Code.as(:c).query.where("NOT EXISTS { (c)-[:Contains]-(:Category) }").return("COUNT(DISTINCT c) AS ct").uniq.map{|c| c[:ct]}.first
  end
  
  def frequency
    @frequency ||= self.survey_responses.count  
  end

  def dimension_list
    @dimension_list ||= self.dimensions.pluck(:name)
  end
  
  def persona_list
    @persona_list ||= self.query_as(:c).match("(c)-[]-(:SurveyResponse)-[]-(p:Persona)").return("DISTINCT p.identifier AS identifier").order("identifier").map{|r| r[:identifier]}
  end
  
  def persona_count
    @persona_count ||= persona_list.count
  end

  def question_list
    @questions ||= self.survey_responses.as(:s).query.match("(s:SurveyResponse)-[]-(si:SurveyItem)").return("DISTINCT si.identifier AS identifier").order("identifier").map{|r| r[:identifier]}.map{|identifier| "Q#{identifier.to_s.rjust(3, "0")}"}
  end
  
  private

  def sanitize
    self.name.strip!
  end

end

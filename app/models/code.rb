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

  def self.applied(limit:)
    if limit
      Code.as(:c).query.match("(c)-[]-(SurveyResponse)").return("DISTINCT c").order("c.name DESC").limit(limit).map{|r| r[:c]}
    else
      Code.as(:c).query.match("(c)-[]-(SurveyResponse)").return("DISTINCT c").order("c.name DESC").map{|r| r[:c]}
    end
  end

  def self.categorized
    Code.as(:c).query.match("(c)-[]-(:Category)").return("DISTINCT c").uniq.map{|r| r[:c]}
  end

  def self.uncategorized
    Code.as(:c).query.where("NOT EXISTS { (c)-[]-(:Category) }").return(:c).map{|r| r[:c]}
  end

  def frequency
    @frequency ||= self.survey_responses.count  
  end

  def dimension_list
    @dimension_list ||= self.dimensions.pluck(:name)  
  end
  
  def personas_list
    @personas_list ||= self.survey_responses.as(:query).query.match("(p:Persona)-[]-(s)").return("p.identifier").map{|r| r[:s]}
  end
  
  def personas_count
    @personas_count ||= self.survey_responses.as(:s).query.match("(p:Persona)-[]-(s)").return("COUNT(p)").map{|r| r[:s]}.first
  end

  def question_list
    @questions ||= self.survey_responses.as(:s).query.match("(s:SurveyResponse)-[]-(si:SurveyItem)").return("si.identifier").map{|r| r[:s]}.map{|identifier| "Q#{identifier.to_s.rjust(3, '0')}" }
  end
  
  def self.personas_histogram(personas)
    codes = self.survey_responses.as(:s).query.match("(p:Persona)-[]-(s:SurveyResponse)").with("p.identifier AS name, COUNT(p) AS ct").return("name, ct").order("ct DESC").map{|r| r[:s]}
    codes.to_h { |code| [code[0], code[1]] }
  end
  
  def self.survey_items_histogram(survey_item)
    codes = survey_item.survey_responses.as(:sr).query.match("(sr:SurveyResponse)-[]-(c:Code)").with("c, count(c) AS ct").return('c.label, ct').order("ct DESC")
    codes.to_h { |code| [code[0].to_s, code[1].to_i] }
  end

  private

  def sanitize
    self.name.strip!
  end

end

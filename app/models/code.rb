class Code
  include ActiveGraph::Node

  attr_accessor :action

  property :label
  property :dimension
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize
  validates :label, presence: true
  validates_uniqueness_of :label
  
  has_many :in, :categories, type: :Contains, model_class: "Category"
  has_many :in, :survey_responses, type: :AssociatedWith, model_class: "SurveyResponse"
  has_many :out :identity_dimensions, type: :RelatesTo, model_class: "Dimension"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_one :out, :researcher, type: :CodesAs, model_class: "Researcher"

  def self.applied
    Code.as(:c).query.match("(c)-[]-(SurveyItem)").return("DISTINCT c").order("c.label DESC").limit(10).map{|r| r[:c]}
  end

  def self.categorized
    Code.as(:c).query.match("(c)-[]-(:Category)").return("DISTINCT c").uniq.map{|r| r[:c]}
  end

  def self.uncategorized
    Code.as(:c).query.where("NOT EXISTS { (c)-[]-(:Category) }").return(:c)
  end

  def detach_from(survey_response)
    self.survey_responses.delete(survey_response)
    self.personas.delete(survey_response.persona)
  end

  def dimensions
    @dimensions ||= Code.where(label: self.label).pluck(:dimension).uniq.sort
  end

  def frequency
    @frequency ||= self.survey_responses.count  
  end
    
  def questions
    @questions ||= SurveyItem.as(:s).query.match("(s)-[]-(:SurveyResponse)-[]-(c:Code)").where("c.label = $label").params(label: self.label).return(:s).pluck("s.identifier").compact.uniq.sort.map{ |identifier| "Q#{identifier.to_s.rjust(3, '0')}" }
  end

  def personas
    @personas ||= Persona.as(:p).query.match("(p)-[]-(:SurveyResponse)-[]-(c:Code)").where("c.label = $label").params(label: self.label).return(:p).count
  end
    
  private

  def sanitize
    self.label.strip!
  end

end

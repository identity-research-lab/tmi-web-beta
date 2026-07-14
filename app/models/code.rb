class Code
  include ActiveGraph::Node

  attr_accessor :action
  
  property :label
  property :dimension
  property :is_reflection, default: false
  property :is_identity, default: false
  property :is_experience, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize
  validates :label, presence: true
  validates :dimension, presence: true
  validates_uniqueness_of :label, scope: :dimension

  has_many :in, :categories, type: :Contains, model_class: "Category"
  has_many :in, :survey_responses, type: :AssociatedWith, model_class: "SurveyResponse"
  has_many :in, :personas, type: :Experiences, model_class: "Persona"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def self.applied
    Code.as(:c).query.match("(c)-[]-(SurveyItem)").return(:c)
  end

  def self.experiences
    where(is_experience: true)
  end
  
  def self.identities
    where(is_identity: true)
  end
  
  def self.reflections
    where(is_reflection: true)
  end
  
  # Given a dimension, generates a hash with each unique Code as a key and the count of its uses as a value.
  def self.histogram(survey_item)
    codes = survey_item.survey_responses.as(:sr).query.match("(sr)-[]-(c:Code)").with("c, count(c) AS ct").return('c.label, ct').order("ct DESC")
    codes.to_h { |code| [code[0], code[1]] }
  end

  def detach_from(survey_response)
    self.survey_responses.delete(survey_response)
    self.personas.delete(survey_response.persona)
  end
  
  def kind
    return "experience" if self.is_experience?
    return "identity" if self.is_identity?
    return "reflection" if self.is_reflection?
    return "unknown"
  end
  
  private

  def sanitize
    self.label.strip!
  end

end

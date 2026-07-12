class Code
  include ActiveGraph::Node

  attr_accessor :code_name
  
  property :name
  property :dimension
  property :is_reflection, default: false
  property :is_identity, default: false
  property :is_experience, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize
  validates :name, presence: true
  validates :dimension, presence: true
  validates_uniqueness_of :name, scope: :dimension

  has_many :in, :categories, type: :Contains, model_class: "Category"
  has_many :in, :survey_responses, type: :AssociatedWith, model_class: "SurveyResponse"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def self.experiences
    where(is_experience: true)
  end
  
  def self.identities
    where(is_identity: true)
  end
  
  def self.reflections
    where(is_reflection: true)
  end
  
  # Given a dimension, generates a hash with each unique Codes as a key and the counts of its uses as a value.
  def self.histogram(dimension)
    codes = where(dimension: dimension).query_as(:c).with('c, count{(c)-[:EXPERIENCES]-(:Persona)} AS ct').where('ct > 0').order('c DESC').return('c.name, ct')
    codes.inject({}) {|accumulator,code| accumulator[code.values[0]] ||= 0; accumulator[code.values[0]] += code.values[1]; accumulator}
  end

  def kind
    return "experience" if self.is_experience?
    return "identity" if self.is_identity?
    return "reflection" if self.is_reflection?
    return "unknown"
  end
  
  private

  def sanitize
    self.name.strip!
  end

end

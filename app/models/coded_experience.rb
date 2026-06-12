class CodedExperience
  include ActiveGraph::Node

  property :name
  property :dimension_name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize
  validates :name, presence: true
  validates :dimension_name, presence: true
  validates_uniqueness_of :name, scope: :dimension_name

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_many :in, :personas, type: :Experiences, model_class: "Persona"
  has_many :in, :categories, type: :Contains, model_class: "Category"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  # Given a dimension, generates a hash with each unique Codes as a key and the counts of its uses as a value.
  def self.histogram(dimension)
    codes = where(dimension: dimension).query_as(:c).with('c, count{(c)-[:EXPERIENCES]-(:Persona)} AS ct').where('ct > 0').order('c DESC').return('c.name, ct')
    codes.inject({}) {|accumulator,code| accumulator[code.values[0]] ||= 0; accumulator[code.values[0]] += code.values[1]; accumulator}
  end

  private

  def sanitize
    self.name.strip!
  end

end

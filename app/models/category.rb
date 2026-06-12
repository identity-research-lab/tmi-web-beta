# A Category is a label applied to a group of related Codes within a provided dimension.
# For example, a category may refer to a subset of the codes related to "age".
# Categories are machine-derived. As such, they are influenced by biases in external training data.
# Careful human discernment of categories is required to identify and address these biases.
class Category

  include ActiveGraph::Node

  property :name
  property :description
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :dimension

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_many :out, :coded_experiences, type: :Contains, model_class: "CodedExperience"
  has_many :in, :themes, type: :EmergesFrom, model_class: "Theme"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  # Generates a hash with the unique category name as the key and the count of its associated coded experiences as a value.
  def self.histogram(dimension)
    categories = where(dimension: dimension).query_as(:c).with('c, count{(c)-[:CONTAINS]-(coded_experienece:Code)} AS ct').return("c.name, ct").order('ct DESC')
    categories.inject({}) {|accumulator,category| accumulator[category.values[0]] ||= 0; accumulator[category.values[0]] += category.values[1]; accumulator}
  end

end

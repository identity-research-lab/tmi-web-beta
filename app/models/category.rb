# A Category is a label applied to a group of related Codes within a provided dimension.
# For example, a category may refer to a subset of the codes related to "age".
class Category

  include ActiveGraph::Node

  property :name
  property :description
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :out, :codes, type: :Contains, model_class: "Code"
  has_many :in, :personas, type: :RelatesTo, model_class: "Persona"
  has_many :in, :themes, type: :EmergesFrom, model_class: "Theme"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_one :out, :researcher, type: :Categorizes, model_class: "Researcher"

end

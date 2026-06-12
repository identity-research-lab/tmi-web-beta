# A Theme is a label representing a fundamental concept that emerges from the data, in particular clusters of one or more Codes.
class Theme
  include ActiveGraph::Node

  property :name
  property :description
  property :notes
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :out, :categories, type: :EmergesFrom, model_class: "Category"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  private

  def sanitize
    self.name.strip!
  end

end

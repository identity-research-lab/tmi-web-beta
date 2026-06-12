class Reflection
  include ActiveGraph::Node

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :dimension

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_many :in, :personas, rel_class: :IdentifiesWith
  has_many :out, :events, type: :HasEvent
  has_many :out, :memos, type: :HasMemo

  private

  def sanitize
    self.name.strip!
  end

end

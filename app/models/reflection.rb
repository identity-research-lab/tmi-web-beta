class Reflection
  include ActiveGraph::Node

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :dimension

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_many :in, :personas, type: :IdentifiesWith, model_class: "Persona"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  private

  def sanitize
    self.name.strip!
  end

end

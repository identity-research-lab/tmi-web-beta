# An Identity is a word or phrase used by a survey participant to self-describe. Identities have associated dimensions.
class Identity
  include ActiveGraph::Node

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :dimension
  
  belongs_to :dimension
  has_many :in, :personas, rel_class: :IdentifiesWith
  has_many :out, :events

  private

  def sanitize
    self.name.strip!
  end

end

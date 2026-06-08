# Keywords are the nouns extracted from a 'corpus' consisting of the exact text of
# certain freeform response fields. The extraction is performed using AI assistance,
# so results are nondeterminative and must be assessed for bias by the researchers.

class Keyword

  include ActiveGraph::Node

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :dimension
  has_many :in, :personas, rel_class: :ReflectsOn

end

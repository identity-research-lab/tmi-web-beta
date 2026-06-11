class Event
  include ActiveGraph::Node

  property :label
  property :description
  property :created_at, type: DateTime

  validates :label, presence: true
  validates :description, presence: true

  belongs_to :persona
  belongs_to :coded_experience
  belongs_to :identity

end

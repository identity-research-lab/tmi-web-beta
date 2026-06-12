class Event
  include ActiveGraph::Node

  property :label
  property :description
  property :created_at, type: DateTime

  validates :label, presence: true
  validates :description, presence: true

  has_one :out, :persona, type: :HasEvent
  has_one :out, :coded_experience, type: :HasEvent
  has_one :out, :identity, type: :HasEvent
  has_one :out, :reflection, type: :HasEvent
  has_one :out, :project, type: :HasEvent

end

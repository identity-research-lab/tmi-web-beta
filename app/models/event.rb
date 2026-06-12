class Event
  include ActiveGraph::Node

  property :label
  property :description
  property :created_at, type: DateTime

  validates :label, presence: true
  validates :description, presence: true

  has_one :out, :persona, origin: :persona, type: :HasEvent
  has_one :out, :coded_experience, origin: :coded_experience, type: :HasEvent
  has_one :out, :identity, origin: :identity, type: :HasEvent
  has_one :out, :reflection, origin: :reflection, type: :HasEvent
  has_one :out, :project, origin: :project, type: :HasEvent

end

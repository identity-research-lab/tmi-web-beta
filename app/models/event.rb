class Event
  include ActiveGraph::Node

  property :label
  property :description
  property :created_at, type: DateTime

  validates :label, presence: true
  validates :description, presence: true

  has_one :out, :persona, type: :HasEvent
  has_one :out, :code, type: :HasEvent
  has_one :out, :project, type: :HasEvent

  def referrent
    @referrent ||= self.persona || self.code || self.project
  end
  
end

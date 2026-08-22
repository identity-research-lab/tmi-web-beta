class Event
  include ActiveGraph::Node

  property :name
  property :description
  property :created_at, type: DateTime

  validates :name, presence: true
  validates :description, presence: true

  has_one :out, :persona, type: :HasEvent
  has_one :out, :code, type: :HasEvent
  has_one :out, :project, type: :HasEvent

  def referrent
    @referrent ||= self.persona || self.code || self.project
  end
  
end

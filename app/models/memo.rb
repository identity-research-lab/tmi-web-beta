class Memo

  include ActiveGraph::Node

  property :name
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :dimension
  belongs_to :persona
  belongs_to :survey_response
  
end

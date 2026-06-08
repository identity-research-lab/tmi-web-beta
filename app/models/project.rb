class Project
  include ActiveGraph::Node

  property :name, default: "Untitled Project"
  property :researcher, default: "Unspecified Researcher"
  property :csv_data
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :refreshed_at, type: DateTime
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  has_many :out, :survey_items, origin: :project
  
end
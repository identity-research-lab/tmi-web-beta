class SurveyItem
  include ActiveGraph::Node

  property :prompt
  property :label
  property :is_experience, default: false
  property :is_identity, default: false
  property :is_reflection, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  belongs_to :dimension
  has_many :survey_responses
    
end

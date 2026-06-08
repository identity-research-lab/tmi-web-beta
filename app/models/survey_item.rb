class SurveyItem
  include ActiveGraph::Node

  property :prompt
  property :label
  property :is_experience, default: false
  property :is_identity, default: false
  property :is_reflection, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension" 
  # has_one :in, :project, type: :project
  # has_many :survey_responses, type: :survey_response
  
  scope :experience_items, where: { is_experience: true }
end

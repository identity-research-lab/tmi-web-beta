class SurveyResponse
  include ActiveGraph::Node

  property :value
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  belongs_to :dimension
  belongs_to :survey_item
  belongs_to :persona, rel_class: :RespondsWith
  
end

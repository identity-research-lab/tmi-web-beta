class SurveyResponse
  include ActiveGraph::Node

  property :value
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

   has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
   has_one :out, :survey_item, type: :HasItem, model_class: "SurveyItem"
   has_one :out, :persona, type: :RespondsWith, model_class: "Persona"

  has_many :memos

end

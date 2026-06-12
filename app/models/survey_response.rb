class SurveyResponse
  include ActiveGraph::Node

  property :value
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :value, presence: true

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_one :out, :survey_item, type: :HasItem, model_class: "SurveyItem"
  has_one :out, :persona, type: :RespondsWith, model_class: "Persona"
  has_one :out, :project, type: :HasProject, model_class: "Project"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

end

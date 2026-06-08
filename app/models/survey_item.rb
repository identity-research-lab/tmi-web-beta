class SurveyItem
  include ActiveGraph::Node

  property :prompt
  property :label
  property :csv_header
  property :is_participant_identifier, default: false
  property :is_experience, default: false
  property :is_identity, default: false
  property :is_reflection, default: false
  property :is_ignored, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension" 
  has_one :out, :project, type: :HasProject, model_class: "Project" 
  # has_one :in, :project, type: :project
  # has_many :survey_responses, type: :survey_response
  
  def self.active_items
    where(is_ignored: false)
  end

  def self.ignored_items
    where(is_ignored: true)
  end
  
  def self.experience_items
    where(is_experience: true) || []
  end

  def self.identity_items
    where(is_identity: true) || []
  end
  
  def self.reflection_items
    where(is_reflection: true) || []
  end
  
  def self.participant_identifier_item
    find_by(is_participant_identifier: true)
  end
  
end

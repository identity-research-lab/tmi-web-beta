class SurveyItem
  include ActiveGraph::Node

  attr_accessor :item_kind
  
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

  KINDS = [:participant_identifier, :experience, :identity, :reflection]
  
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

  def item_kind=(kind)
    return unless kind && KINDS.include?(kind.to_sym)
    case @item_kind.to_sym
    when :participant_identifier
      self.update(is_participant_identifier: true, is_experience: false, is_identity: false, is_reflection: false)
    when :experience
      self.update(is_participant_identifier: false, is_experience: true, is_identity: false, is_reflection: false)
    when :identity
      self.update(is_participant_identifier: false, is_experience: false, is_identity: true, is_reflection: false)
    when :reflection
      self.update(is_participant_identifier: false, is_experience: false, is_identity: false, is_reflection: true)
    end
  end
  
  def clear_kind
    
  end
  
end

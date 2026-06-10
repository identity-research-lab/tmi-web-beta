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
  property :is_active, default: true
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension" 
  has_one :out, :project, type: :HasProject, model_class: "Project" 
  # has_one :in, :project, type: :project
  # has_many :survey_responses, type: :survey_response

  before_save :translate_item_kind
  
  KINDS = [:participant_identifier, :experience, :identity, :reflection]
  
  def self.active_items
    where(is_active: true)
  end

  def self.ignored_items
    where(is_active: false)
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

  def translate_item_kind
    return if @item_kind.nil?
    return unless KINDS.include?(@item_kind.to_sym)
    case @item_kind
    when "participant_identifier"
      self.is_participant_identifier = true
      self.is_experience = false
      self.is_identity = false
      self.is_reflection = false
    when "experience"
      self.is_participant_identifier = false
      self.is_experience = true
      self.is_identity = false
      self.is_reflection = false
    when "identity"
      self.is_participant_identifier = false
      self.is_experience = false
      self.is_identity = true
      self.is_reflection = false
    when "reflection"
      self.is_participant_identifier = false
      self.is_experience = false
      self.is_identity = false
      self.is_reflection = true
    end
  end
  
end

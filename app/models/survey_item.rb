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
  property :is_completed, type: Boolean, default: false
  property :is_coded, type: Boolean, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  has_many :in, :survey_responses, type: :HasItem, model_class: "SurveyResponse"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_many :out, :codes, type: :AssociatedWith, model_class: "Code"
  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_one :out, :project, type: :HasProject, model_class: "Project"

  before_save :translate_item_kind
  before_save :sanitize_active_flag

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

  def self.completed
    where(is_completed: true)
  end

  def self.in_progress
    where(is_completed: false, is_coded: true)
  end

  def self.uncoded
    where(is_coded: false)
  end

  def formatted_identifier
    (project.survey_fields.index(self.csv_header) + 1).to_s.rjust(3, "0")
  end

  # Displays the query and its explanation for locating the Case's associated Persona in the graph.
  def graph_query
    {
      explainer: "Access and explore this survey item (and all of its relationships) in the TMI-Graph app.",
      query: "MATCH (si:SurveyItem)-[]-(n) WHERE si.csv_header=\"#{self.csv_header}\" RETURN p,n"
    }
  end

  def status
    return "Completed" if self.is_completed?
    return "In Progress" if self.is_coded?
    return "Not Started"
  end

  def complete!
    update_attributes(is_completed: true)
    Event.create(persona: self, label: "Persona #{self.identifier}", description: "Coding completed.")
  end

  # Force to boolean. Sorry.
  def sanitize_active_flag
    case self.is_active
    when '1'
      self.is_active = true
    when '0'
      self.is_active = false
    when nil
      self.is_active = false
    end
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

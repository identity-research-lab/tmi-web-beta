class Persona
  include ActiveGraph::Node

  property :identifier
  property :participant_id
  property :permalink
  property :is_completed, type: Boolean, default: false
  property :is_coded, type: Boolean, default: false
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :participant_id, presence: true
  validates :participant_id, uniqueness: true
  validates :identifier, presence: true
  validates :identifier, uniqueness: true

  has_many :in, :memos, type: :HasMemo, model_class: "Memo"
  has_many :out, :survey_responses, type: :RespondsWith, model_class: "SurveyResponse"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :identities, type: :IdentifiesWith, model_class: "Code"
  has_many :out, :experiences, type: :Experiences, model_class: "Code"
  has_many :out, :reflections, type: :ReflectsOn, model_class: "Code"

  def self.completed
    where(is_completed: true)
  end

  def self.in_progress
    where(is_completed: false, is_coded: true)
  end

  def self.uncoded
    where(is_coded: false)
  end

  # Displays the query and its explanation for locating the Case's associated Persona in the graph.
  def graph_query
    {
      explainer: "Access and explore this case (and all of its relationships) as an Interactive Persona in the TMI-Graph app.",
      query: "MATCH (p:Persona)-[]-(n) WHERE p.identifier=\"#{self.identifier}\" RETURN p,n"
    }
  end

  def formatted_identifier
    "Persona #{self.identifier.to_s.rjust(3, "0")}"
  end

  def status
    return "Completed" if self.is_completed?
    return "In Progress" if self.is_coded?
    return "Not Started"
  end

  def coded!
    update_attributes(is_coded: true, is_completed: false)
    Event.create(persona: self, label: "Persona #{self.identifier}", description: "Coding started.")
  end
  
  def complete!
    update_attributes(is_completed: true)
    Event.create(persona: self, label: "Persona #{self.identifier}", description: "Coding completed.")
  end

   # Calculates the permanent URL of the Case, which is stored as a property on the associated Persona.
  def permalink
    if Rails.env == "development"
#      Rails.application.routes.url_helpers.url_for(controller: "personas", action: "show", host: "localhost", port: 3000, id: self.id)
    else
#      Rails.application.routes.url_helpers.url_for(controller: "personas", action: "show", host: ENV.fetch("HOSTNAME", "localhost"), id: self.id)
    end
  end

end

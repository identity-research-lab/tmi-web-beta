class Persona
  include ActiveGraph::Node

  property :participant_id
  property :permalink
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :participant_id, presence: true
  validates :participant_id, uniqueness: true

  has_many :out, :coded_experiences, type: :Experiences, model_class: "CodedExperience"
  has_many :out, :identities, type: :IdentifiesWith, model_class: "Identity"
  has_many :out, :reflections, type: :ReflectsOn, model_class: "Reflection"
  has_many :out, :survey_responses, type: :RespondsWith, model_class: "SurveyResponse"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  # Displays the query and its explanation for locating the Case's associated Persona in the graph.
  def graph_query
    {
      explainer: "Access and explore this case (and all of its relationships) as an Interactive Persona in the TMI-Graph app.",
      query: "MATCH (p:Persona)-[]-(n) WHERE p.case_id=#{self.id} RETURN p,n"
    }
  end

  # Convenience method to pad ID.
  def identifier
    self.id.to_s.rjust(4, "0")
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

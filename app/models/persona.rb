class Persona
  include ActiveGraph::Node

  property :name
  property :permalink
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true

  has_one :case
  has_many :out, :coded_experiences, rel_class: :Experiences
  has_many :out, :identities, rel_class: :IdentifiesWith
  has_many :out, :reflections, rel_class: :ReflectsOn
  has_many :out, :survey_responses, rel_class: :RespondsWith
  has_many :out, :memos
  has_many :out, :events
  
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
      Rails.application.routes.url_helpers.url_for(controller: "cases", action: "show", host: "localhost", port: 3000, id: self.id)
    else
      Rails.application.routes.url_helpers.url_for(controller: "cases", action: "show", host: ENV.fetch("HOSTNAME", "localhost"), id: self.id)
    end
  end
  
end

# RespondsWith defines the unique relation (edge) between a Persona and a SurveyResponse.
class RespondsWith
  
  include ActiveGraph::Relationship
  
  from_class :Persona
  to_class   :SurveyResponse
  creates_unique :all

end

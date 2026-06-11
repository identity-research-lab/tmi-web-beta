class Dimension
  include ActiveGraph::Node

  property :name

  has_many :in, :survey_items, origin: :dimension
  has_many :in, :survey_responses, origin: :dimension
  #  :coded_experiences, type: :coded_experience
  #  :identities, type: :identity
  #  :keywords, type: :keyword

end

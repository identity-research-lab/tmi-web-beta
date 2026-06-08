class Dimension
  include ActiveGraph::Node
  
  property :name

  has_many :in, :survey_items, origin: :dimension
  # has_many :coded_experiences, type: :coded_experience
  # has_many :identities, type: :identity
  # has_many :keywords, type: :keyword
  # has_many :survey_responses, type: :survey_response
  # has_many :survey_items, type: :survey_item, origin: :survey_item
  
end
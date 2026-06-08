class Dimension
  include ActiveGraph::Node
  
  property :name

  has_many :coded_experiences
  has_many :identities
  has_many :keywords
  has_many :survey_responses
  has_many :survey_questions
  
end
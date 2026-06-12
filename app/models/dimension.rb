class Dimension
  include ActiveGraph::Node

  property :name

  has_many :in, :survey_items, type: :HasDimension
  has_many :in, :survey_responses, type: :HasDimension
  has_many :in, :coded_experiences, type: :HasDimension
  has_many :in, :identities, type: :HasDimension
  has_many :in, :reflections, type: :HasDimension

end

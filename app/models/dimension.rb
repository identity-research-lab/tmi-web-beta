class Dimension
  include ActiveGraph::Node

  property :name

  has_many :in, :survey_items, origin: :dimension, type: :HasDimension
  has_many :in, :survey_responses, origin: :dimension, type: :HasDimension
  has_many :in, :coded_experiences, origin: :dimension, type: :HasDimension
  has_many :in, :identities, origin: :dimension, type: :HasDimension
  has_many :in, :reflections, origin: :dimension, type: :HasDimension

end

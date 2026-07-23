class Dimension

  include ActiveGraph::Node

  property :name

  has_many :in, :survey_items, type: :RelatesTo
  has_many :in, :survey_responses, type: :RelatesTo
  has_many :in, :codes, type: :RelatesTo
  has_many :in, :reflections, type: :RelatesTo

end

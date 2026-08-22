# A Category is a label applied to a group of related Codes within a provided dimension.
# For example, a category may refer to a subset of the codes related to "age".
class Category

  include ActiveGraph::Node

  property :name
  property :description
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :out, :codes, type: :Contains, model_class: "Code"
  has_many :in, :themes, type: :EmergesFrom, model_class: "Theme"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_one :out, :researcher, type: :Categorizes, model_class: "Researcher"

  def self.assigned
    Category.as(:c).query.match("(c)-[]-(:Theme)").return(:c)
  end
  
  def self.unassigned
    Category.as(:c).query.where("NOT EXISTS { (c)-[]-(:Theme) }").return(:c)
  end
  
  # Displays the query and its explanation for locating the Case's associated Persona in the graph.
  def graph_query
    {
      explainer: "Access and explore this category (and all of its relationships) in the TMI-WEB graph.",
      query: "MATCH (c:Category)-[]-(n) WHERE c.name=\"#{self.name}\" RETURN c,n"
    }
  end
  
end

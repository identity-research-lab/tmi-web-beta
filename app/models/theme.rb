class Theme
  include ActiveGraph::Node

  property :name
  property :description
  property :notes
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  before_validation :sanitize

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :out, :categories, type: :EmergesFrom, model_class: "Category"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def graph_query
    {
      explainer: "Access and explore this theme (and all of its relationships) in the TMI-WEB graph.",
      query: "MATCH (t:Theme)-[]-(n) WHERE t.name=\"#{self.name}\" RETURN t,n"
    }
  end

  private

  def sanitize
    self.name.strip!
  end

end

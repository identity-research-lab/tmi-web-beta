class Researcher

  include ActiveGraph::Node
  
  property :name, default: "Default Researcher"
  property :public_contact_info
  property :affiliation
  property :positionality
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  
  validates :name, presence: true
  validates :positionality
  
  has_many :out, :categories, type: :Categorized, model_class: "Category"
  has_many :out, :codes, type: :Coded, model_class: "Code"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"
  has_many :out, :themes, type: :Derived, model_class: "Theme"
  
end
class Memo

  include ActiveGraph::Node

  property :text
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :text, presence: true

  has_one :out, :persona, type: :HasMemo
  has_one :out, :coded_experience, type: :HasMemo
  has_one :out, :identity, type: :HasMemo
  has_one :out, :reflection, type: :HasMemo
  has_one :out, :project, type: :HasMemo
  has_one :out, :survey_item, type: :HasMemo
  has_one :out, :survey_response, type: :HasMemo

end

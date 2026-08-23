class Memo

  include ActiveGraph::Node

  property :text
  property :kind
  property :referrent_id
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :text, presence: true
  validates :kind, presence: true
  validates :referrent_id, presence: true

  before_save :attach_referrent
  
  has_one :out, :category, type: :HasMemo
  has_one :out, :persona, type: :HasMemo
  has_one :out, :project, type: :HasMemo
  has_one :out, :researcher, type: :HasMemo
  has_one :out, :survey_item, type: :HasMemo
  has_one :out, :theme, type: :HasMemo

  KINDS = %w{ category persona project survey_item theme }

  def self.category
    where(kind: "category")
  end
  
  def attach_referrent
    return unless KINDS.include? self.kind
    return unless self.referrent_id.present?
    case self.kind
      when "category"
        if category = Category.find(self.referrent_id)
          self.category = category
        end
      when "persona"
        if persona = Persona.find(self.referrent_id)
          self.persona = persona
        end
      when "project"
        if project = Project.find(self.referrent_id)
          self.project = project
        end
      when "survey_item"
        if survey_item = SurveyItem.find(self.referrent_id)
          self.survey_item = survey_item
        end
      when "theme"
        if theme = Theme.find(self.referrent_id)
          self.theme = theme
        end
    end
  end
  
  def referrent
    self.category || self.project || self.persona || self.survey_item || self.theme
  end
    
end

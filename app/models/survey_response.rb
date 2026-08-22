class SurveyResponse
  include ActiveGraph::Node

  property :value
  property :is_coded, type: Boolean, default: false

  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :value, presence: true
    
  has_one :out, :dimension, type: :HasDimension, model_class: "Dimension"
  has_one :out, :survey_item, type: :HasItem, model_class: "SurveyItem"
  has_one :in, :persona, type: :RespondsWith, model_class: "Persona"
  has_one :out, :project, type: :HasProject, model_class: "Project"
  has_many :out, :codes, type: :AssociatedWith, model_class: "Code"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def self.coded
    where(is_coded: true)
  end

  def self.experiences
    SurveyResponse.as(:sr).query.match("(sr)-[]-(si:SurveyItem)").where("si.is_experience = $value").params(value: true).return(:sr).map{|r| r[:sr]}
  end
  
  def self.identities
    SurveyResponse.as(:sr).query.match("(sr)-[]-(si:SurveyItem)").where("si.is_identity = $value").params(value: true).return(:sr).map{|r| r[:sr]}
  end
  
  def self.reflections
    SurveyResponse.as(:sr).query.match("(sr)-[]-(si:SurveyItem)").where("si.is_reflection = $value").params(value: true).return(:sr).map{|r| r[:sr]}
  end

end

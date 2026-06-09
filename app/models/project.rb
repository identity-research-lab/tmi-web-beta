class Project

  require 'csv'

  include ActiveGraph::Node
  
  property :name, default: "Untitled Project"
  property :researcher, default: "Unspecified Researcher"
  property :csv_data
  property :participant_id_field
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :refreshed_at, type: DateTime
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  has_many :in, :survey_items, type: :HasProject
  
  def active_fields
    @active_fields ||= self.survey_items.where(is_ignored: false)
  end
  
  def survey_fields  
    CSV.parse(self.csv_data, headers: true).headers
  end
  
  def create_survey_items_from_csv
    survey_fields.each do |field|
      item = SurveyItem.find_or_create_by(csv_header: field, project: self)
    end
  end
  
end
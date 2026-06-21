class Project

  require 'csv'

  include ActiveGraph::Node

  property :name, default: "Untitled Project"
  property :researcher, default: "Unspecified Researcher"
  property :csv_data
  property :participant_id_field, default: "participant_id"
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :refresh_started_at, type: DateTime
  property :refreshed_at, type: DateTime
  property :refresh_in_progress, type: Boolean, default: false

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :in, :survey_items, type: :HasProject, model_class: "SurveyItem"
  has_many :in, :survey_responses, type: :HasProject, model_class: "SurveyResponse"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def active_fields
    @active_fields ||= self.survey_items.where(is_active: true)
  end

  def survey_fields
    CSV.parse(self.csv_data, headers: true).headers.reject{ |f| f == self.participant_id_field }
  end

  def create_survey_items_from_csv
    survey_fields.each do |field|
      survey_items.find_or_create_by(csv_header: field)
    end
    Event.create(project: self, label: "Survey items", description: "Survey items refreshed from upload.")
  end

  def create_survey_responses_from_csv
    self.update_attributes(refresh_started_at: DateTime.now)
#    Services::ImportFromCsv.perform(self.id)
    PopulateSurveyResponsesJob.perform_later(project_id: self.id)
    Event.create(project: self, label: "Survey responses", description: "Survey responses import started.")
  end

end

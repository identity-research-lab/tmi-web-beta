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

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :in, :survey_items, type: :HasProject, model_class: "SurveyItem"
  has_many :out, :events, type: :HasEvent, model_class: "Event"
  has_many :out, :memos, type: :HasMemo, model_class: "Memo"

  def active_fields
    @active_fields ||= self.survey_items.where(is_active: true)
  end

  def survey_fields
    CSV.parse(self.csv_data, headers: true).headers
  end

  def survey_responses_load_in_progress?
    return false unless self.refresh_started_at
    return true if self.refresh_started_at && self.refreshed_at.nil?
    return false if self.refresh_started_at < self.refreshed_at
    return true if self.refresh_started_at >= self.refreshed_at
    return false
  end

  def survey_responses_load_progress
    total_records = CSV.parse(self.csv_data, headers: true).count
    total_responses =  total_records * active_fields.count
    in_db = SurveyResponse.count
    "#{in_db}/#{total_responses}"
  end

  # TODO event
  def create_survey_items_from_csv
    survey_fields.each do |field|
      item = SurveyItem.find_or_create_by(csv_header: field, project: self)
    end
  end

  # TODO event
  def create_survey_responses_from_csv
    self.update_attributes(refresh_started_at: DateTime.now)
#    Services::ImportFromCsv.perform(self.id)
    PopulateSurveyResponsesJob.perform_later(project_id: self.id)
  end

end

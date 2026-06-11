class PopulateSurveyResponsesJob < ApplicationJob

  require 'csv'

  queue_as :default

  def perform(project_id:)
    return unless project_id
    Services::ImportFromCsv.perform(project_id)
  end
end

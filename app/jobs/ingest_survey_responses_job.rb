class IngestSurveyResponsesJob < ApplicationJob

  require 'csv'

  queue_as :default

  def perform(*args)
  end
end

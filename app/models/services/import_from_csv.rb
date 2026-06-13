module Services

	require 'csv'

	# Upserts/merges data as CSV file is imported, meaning that this operation is non-destructive and will not re-import existing data.

	class ImportFromCsv

		attr_accessor :project
		attr_accessor :record

		# Parse the project's CSV field to create or update Persona and SurveyResponse items
		def self.perform(project_id)
			return unless project = Project.find(project_id)
			return unless project.participant_id_field.present?
			return unless project.csv_data.present?

			begin
				project.update_attributes(refresh_in_progress: true)
				survey_items = project.active_fields

				records = CSV.parse(project.csv_data, headers: true)
				records.each do |record|
					next unless persona = Persona.find_or_create_by(participant_id: record[project.participant_id_field])
					survey_items.each do |survey_item|
						survey_response = SurveyResponse.find_or_initialize_by(
							persona: persona,
							survey_item: survey_item
						)
						survey_response.dimension = survey_item.dimension
						survey_response.value = record[survey_item.csv_header] || "No response"
						survey_response.save!
					end
				end
				project.update_attributes(refreshed_at: DateTime.now, refresh_in_progress: false)
				Event.create(project: project, label: "Survey responses", description: "Survey responses import completed, #{records.count} cases refreshed.")
			rescue Exception
				project.update_attributes(refresh_in_progress: false)
				Event.create(project: project, label: "Survey responses", description: "Survey responses import failed.")
			end
		end

	end
end

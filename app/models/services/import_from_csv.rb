module Services

	require 'csv'

	# Upserts/merges data as CSV file is imported, meaning that this operation is non-destructive and will not re-import existing data.

	class ImportFromCsv

		attr_accessor :project
		attr_accessor :record

		# Parse the project's CSV field to create or update Persona and SurveyResponse items
		# TODO event log
		def self.perform(project_id)
			return unless project = Project.find(project_id)
			return unless project.participant_id_field.present?
			return unless project.csv_data.present?

			survey_items = project.active_fields

			records = CSV.parse(project.csv_data, headers: true)
			records.each do |record|
				next unless persona = Persona.find_or_create_by(participant_id: record[project.participant_id_field])
				survey_items.each do |survey_item|
					survey_response = SurveyResponse.find_or_initialize_by(
						persona_id: record[project.participant_id_field],
						survey_item_id: survey_item.id,
						dimension_id: survey_item.dimension_id,
					)
					survey_response.value = record[survey_item.csv_header]
					survey_response.save
				end
			end
			project.update_attributes(refreshed_at: DateTime.now)
		end

	end
end

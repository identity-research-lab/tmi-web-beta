namespace :import do

  desc 'Import identity records from a CSV file'
  task identities: :environment do
    require 'csv'
  
    file_path = Rails.root.join('data', 'identities.csv')
    starting_code_count = Code.count
    imported_code_count = 0
    records = {}
    missing = []
              
    DIMENSION_MAP = {
      "age" => "Age",
      "class" => "Class",
      "race-ethnicity" => "Race/Ethnicity",
      "religion" => "Religion",
      "disability" => "Disability",
      "neurodiversity" => "Neurodiversity",
      "gender" => "Gender",
      "lgbtqia" => "LGBTQIA+ Status"
    }
  
    # Open the CSV file and write the data
    CSV.foreach(file_path, headers: true) do |row|
      persona_id = row[0].to_s.rjust(4, "0")
      label = row[1]
      dimension = row[2]
      if DIMENSION_MAP[dimension]
        records[persona_id] ||= []
        records[persona_id] << { label: label, dimension: DIMENSION_MAP[dimension] }
      end
    end
  
        
    records.each do |id,codes|
      if persona = Persona.find_by(identifier: id)
        codes.each do |code_item|
          if survey_response = persona.survey_responses.as(:sr).query.match("(sr)-[]-(si:SurveyItem)-[]-(d:Dimension)").where("d.name = $name").where("si.is_identity = true").params(name: code_item[:dimension]).return(:sr).pluck(:sr).first
            code = Code.find_or_create_by(label: code_item[:label], dimension: code_item[:dimension], is_identity: true)
            code.personas << persona
            code.survey_responses << survey_response
            imported_code_count += 1
          end
        end
      end
    end
  
    puts "#{imported_code_count - starting_code_count} new codes imported from #{file_path}."
    
  end
  
  desc 'Import code records from a CSV file'
  task codes: :environment do
    require 'csv'
  
    file_path = Rails.root.join('data', 'codes.csv')
    starting_code_count = Code.count
    imported_code_count = 0
    records = {}
    missing = []
               
    DIMENSION_MAP = {
      "age" => "Age",
      "class" => "Class",
      "race-ethnicity" => "Race/Ethnicity",
      "religion" => "Religion",
      "disability" => "Disability",
      "neurodiversity" => "Neurodiversity",
      "gender" => "Gender",
      "lgbtqia" => "LGBTQIA+ Status"
    }
  
    # Open the CSV file and write the data
    CSV.foreach(file_path, headers: true) do |row|
      persona_id = row[0].to_s.rjust(4, "0")
      label = row[1]
      dimension = row[2]
      if DIMENSION_MAP[dimension]
        records[persona_id] ||= []
        records[persona_id] << { label: label, dimension: DIMENSION_MAP[dimension] }
      end
    end
  
         
    records.each do |id,codes|
      if persona = Persona.find_by(identifier: id)
        codes.each do |code_item|
          if survey_response = persona.survey_responses.as(:sr).query.match("(sr)-[]-(si:SurveyItem)-[]-(d:Dimension)").where("d.name = $name").where("si.is_experience = true").params(name: code_item[:dimension]).return(:sr).pluck(:sr).first
            code = Code.find_or_create_by(label: code_item[:label], dimension: code_item[:dimension], is_experience: true)
            code.personas << persona
            code.survey_responses << survey_response
            imported_code_count += 1
          end
        end
      end
    end
  
    puts "#{imported_code_count - starting_code_count} new codes imported from #{file_path}."
    
  end

end
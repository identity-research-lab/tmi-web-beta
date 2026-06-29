class CodesController < ApplicationController
  
  def index
    @project = Project.last
    @survey_items = @project.active_fields.all.sort{|a,b| a.formatted_identifier <=> b.formatted_identifier }
  end
  
end
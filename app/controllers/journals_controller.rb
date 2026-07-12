class JournalsController < ApplicationController
  
  def show
    @project = Project.last
    @journal = Journal.new
    @entries = @journal.entries
  end
  
end
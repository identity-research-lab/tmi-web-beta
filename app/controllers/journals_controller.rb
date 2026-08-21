class JournalsController < ApplicationController
  
  def show
    @journal = Journal.new
    @entries = @journal.entries
  end
  
end
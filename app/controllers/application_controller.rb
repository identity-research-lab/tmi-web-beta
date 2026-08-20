class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :scope_context
    
  private
  
  def scope_context
    @researcher = Researcher.last
    @researcher ||= Researcher.create
    @project = Project.last
    @project ||= Project.create(researcher: @researcher)
  end
        
end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :scope_project
  
  private
  
  def scope_project
    @project = Project.last
    @project ||= Project.create
  end
        
end

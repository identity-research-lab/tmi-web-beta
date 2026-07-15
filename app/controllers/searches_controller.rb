class SearchesController < ApplicationController
  
  def index
    @project = Project.last
    @search ||= Search.new("")
  end

  def create
    @project = Project.last
    @search = Search.new(params[:search][:query])
    render :index
  end
  
end
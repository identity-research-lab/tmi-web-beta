class SearchesController < ApplicationController
  
  def index
    @search ||= Search.new("")
  end

  def create
    @search = Search.new(params[:search])
    render :index
  end
  
end
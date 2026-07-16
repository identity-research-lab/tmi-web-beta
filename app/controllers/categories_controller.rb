class CategoriesController < ApplicationController
  
  def index
    @project = Project.last
    @categories = Category.all
  end
  
end
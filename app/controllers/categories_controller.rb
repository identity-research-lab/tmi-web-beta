class CategoriesController < ApplicationController

  def index
    @project = Project.last
    @categories = Category.all
    @code_count = Code.count
    @categorized_code_count = Code.categorized.count
    @uncategorized_code_count = Code.uncategorized.count
  end

end

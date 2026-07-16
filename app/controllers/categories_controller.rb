class CategoriesController < ApplicationController

  def index
    @project = Project.last
    @categories = Category.all
    @code_count = Code.count
    @categorized_code_count = Code.categorized.count
    @uncategorized_code_count = Code.uncategorized.count
  end

  def create
    @category = Category.find_or_create_by(category_params)
    @categories = Category.all
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

end

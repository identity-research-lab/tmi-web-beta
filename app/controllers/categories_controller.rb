class CategoriesController < ApplicationController

  def index
    @project = Project.last
    @categories = Category.all
    @code_count = Code.count
    @categorized_code_count = Code.categorized.count
    @uncategorized_code_count = Code.uncategorized.count
  end

  def create
    @category = Category.find_or_create_by(name: category_params[:name])
    @category.description = category_params[:description]
    @category.save!
    @categories = Category.all
    redirect_to categories_path
  end

  def show
    @category = Category.find(params[:id])
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
  
  def update
    @category = Category.find(params[:id])
    # make changes
    success = @category.save
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("XXX", partial: "/categories/yyy", locals: { category: @category, success: success })
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

end

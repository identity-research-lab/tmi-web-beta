class CategoriesController < ApplicationController

  def index
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
    @category_codes = @category.codes
    @codes = Code.applied(25)
    @memos = @category.memos.order(created_at: :desc)
    @memo = Memo.new(kind: "category", referrent_id: @category.id)
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
  
  def update
    @category = Category.find(params[:id])
    if category_params[:code] && code = Code.find(category_params[:code])
      if params[:remove]
        code.categories.delete(@category)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("category-codes", partial: "/categories/codes", locals: { category: @category, codes: @category.codes })
          end
        end
      elsif params[:add]
        code.categories << @category unless code.categories.include? @category
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("category-codes", partial: "/categories/codes", locals: { category: @category, codes: @category.codes })
          end
        end
      end
    end
  end
  
  def codes
  end
  
  private

  def category_params
    params.require(:category).permit(:name, :description, :code)
  end

end

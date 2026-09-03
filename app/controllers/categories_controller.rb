class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order(:name)
    @categorized_code_count = Code.categorized_count
    @uncategorized_code_count = Code.uncategorized_count
    @code_count = @categorized_code_count + @uncategorized_code_count
  end

  def create
    @category = Category.find_or_create_by(name: category_params[:name])
    @category.description = category_params[:description]
    @category.save!
    redirect_to @category
  end

  def edit
    @category = Category.find(params[:id])
    render turbo_stream: turbo_stream.replace("category-header", partial: "/categories/form", locals: { project: @project, category: @category})
  end
  
  def show
    @category = Category.find(params[:id])
    
    respond_to do |format|
      format.html do
        @category_codes = @category.codes
        @codes = Search.new(query: "*", scope: ["code"], per_page: 50, limit: 50, sort_key: "name").paged_results
        @memos = @category.memos.order(created_at: :desc)
        @memo = Memo.new(kind: "category", referrent_id: @category.id)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("category-header", partial: "/categories/show", locals: { project: @project, category: @category})
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])

    code = category_params[:code] && Code.find(category_params[:code])
    if code && params[:remove]
      code.categories.delete(@category)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("category-codes-attached", partial: "/categories/codes", locals: { category: @category, codes: @category.codes, attached_codes: @category.codes, pane: "attached" })
        end
      end
    end
    if code && params[:add]
      code.categories << @category unless code.categories.include? @category
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("category-codes-attached", partial: "/categories/codes", locals: { category: @category, codes: @category.codes, attached_codes: @category.codes, pane: "attached" })
        end
      end
    end

    if category_params[:name]
      @category.update_attributes(name: category_params[:name], description: category_params[:description])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("category-header", partial: "/categories/show", locals: { category: @category, project: @project })
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :code)
  end

end

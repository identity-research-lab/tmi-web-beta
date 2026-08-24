class SearchesController < ApplicationController
  
  def index
    @search ||= Search.new(query: nil)
  end

  def create
    @search = Search.new(query: search_params[:query], scope: search_params[:scope])
    if search_params[:context] == "site"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("search-results", partial: "/searches/results", locals: { search: @search })
          format.html do
            render :index
          end
        end
      end
    elsif search_params[:context] == "theme-details"
      respond_to do |format|
        format.turbo_stream do
          if search_params[:context_id] && theme = Theme.find(search_params[:context_id]) 
            render turbo_stream: turbo_stream.replace("theme-categories-available", partial: "/themes/categories", locals: { theme: theme, categories: @search.category_results, attached_categories: theme.categories, pane: "available" })
          else
            render turbo_stream: turbo_stream.replace("category-grid", partial: "/categories/grid", locals: { categories: @search.category_results })
          end
        end
      end
    elsif search_params[:context] == "category-details"
      respond_to do |format|
        format.turbo_stream do
          if search_params[:context_id] && category = Category.find(search_params[:context_id]) 
            render turbo_stream: turbo_stream.replace("category-codes-available", partial: "/categories/codes", locals: { category: category, codes: @search.code_results, attached_codes: category.codes, pane: "available" })
          else
            render turbo_stream: turbo_stream.replace("category-grid", partial: "/categories/grid", locals: { categories: @search.category_results })
          end
        end
      end
    elsif search_params[:context] == "category-grid"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("category-grid", partial: "/categories/grid", locals: { categories: @search.category_results })
        end
      end
    elsif search_params[:context] == "theme-grid"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("theme-grid", partial: "/themes/grid", locals: { themes: @search.theme_results })
        end
      end
    else
      render :index
    end
  end

  private
  
  def search_params
    params.require(:search).permit(:query, :context, :context_id, :limit, :offset, :per_page, :sort_key, :sort_dir, scope: [])
  end
  
end
class SearchesController < ApplicationController
  
  def index
    @search ||= Search.new("")
  end

  def create
    @search = Search.new(query: search_params[:query], scope: search_params[:scope])
    if @search.scope == "category"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("category-grid", partial: "/categories/grid", locals: { categories: @search.results[:categories] })
        end
      end
    else
      render :index
    end
  end
  
  private
  
  def search_params
    params.require(:search).permit(:query, :scope)
  end
  
end
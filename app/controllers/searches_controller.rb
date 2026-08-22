class SearchesController < ApplicationController
  
  def index
    @search ||= Search.new("")
  end

  def create
    @search = Search.new(params[:search])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("category-codes", partial: "/categories/codes", locals: { category: @category, codes: @category.codes })
      end
    end
  end
  
end
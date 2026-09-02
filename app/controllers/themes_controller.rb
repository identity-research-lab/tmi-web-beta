class ThemesController < ApplicationController

  def index
    @themes = Theme.all
    @categories_count = Category.count
    @assigned_category_count = Category.assigned.count
    @unassigned_category_count = Category.unassigned.count
  end

  def create
    @theme = Theme.find_or_create_by(name: theme_params[:name])
    @theme.description = theme_params[:description]
    @theme.save!
    @themes = Theme.all
    redirect_to @theme
  end

  def edit
    @theme = Theme.find(params[:id])
    render turbo_stream: turbo_stream.replace("theme-header", partial: "/themes/form", locals: { project: @project, theme: @theme})
  end
  
  def show
    @theme = Theme.find(params[:id])
    
    respond_to do |format|
      format.html do
        @theme_categories = @theme.categories
        @all_categories = Category.all
        @memos = @theme.memos.order(created_at: :desc)
        @memo = Memo.new(kind: "theme", referrent_id: @theme.id)
      end
      format.turbo_stream do
        render turbo_stream.replace("theme-header", partial: "/themes/show", locals: { project: @project, theme: @theme })
      end
    end
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to themes_path
  end

  def update
    @theme = Theme.find(params[:id])
  
    category = theme_params[:category] && Category.find(theme_params[:category])
    if category && params[:remove]
      category.themes.delete(@theme)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("theme-categories-attached", partial: "/themes/categories", locals: { theme: @theme, categories: @theme.categories, attached_categories: @theme.categories, pane: "attached" })
        end
      end
    end
    if category && params[:add]
      category.themes << @theme unless category.themes.include? @theme
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("theme-categories-attached", partial: "/themes/categories", locals: { theme: @theme, categories: @theme.categories, attached_categories: @theme.categories, pane: "attached" })
        end
      end
    end
    
    if theme_params[:name]
      @theme.update_attributes(name: theme_params[:name], description: theme_params[:description])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("theme-header", partial: "/themes/show", locals: { theme: @theme, project: @project })
        end
      end
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :description, :category)
  end

end

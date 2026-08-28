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

  def show
    @theme = Theme.find(params[:id])
    @theme_categories = @theme.categories
    @all_categories = Category.all
    @memos = @theme.memos.order(created_at: :desc)
    @memo = Memo.new(kind: "theme", referrent_id: @theme.id)
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to themes_path
  end

  def update
    @theme = Theme.find(params[:id])
    if theme_params[:category] && category = Category.find(theme_params[:category])
      if params[:remove]
        @theme.categories.delete(category)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("theme-categories-attached", partial: "/themes/categories", locals: { theme: @theme, categories: @theme.categories, attached_categories: @theme.categories, pane: "attached" })
          end
        end
      elsif params[:add]
        category.themes << @theme unless category.themes.include? @theme
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("theme-categories-attached", partial: "/themes/categories", locals: { theme: @theme, categories: @theme.categories, attached_categories: @theme.categories, pane: "attached" })
          end
        end
      end
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :description, :category)
  end

end

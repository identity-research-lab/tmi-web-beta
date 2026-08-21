class ThemesController < ApplicationController

  def index
    @themes = Theme.all
    @categories_count = Category.count
    @categories_assigned_count = Category.assigned.count
    @categories_unassigned_count = Category.unassigned.count
  end

  def create
    @theme = Theme.find_or_create_by(name: theme_params[:name])
    @theme.description = theme_params[:description]
    @theme.save!
    @themes = Theme.all
    redirect_to themes_path
  end

  def show
    @theme = Theme.find(params[:id])
  end
  
  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to themes_path
  end
  
  def update
    @theme = Theme.find(params[:id])
    # make changes
    success = @theme.save
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("XXX", partial: "/themes/yyy", locals: { theme: @theme, success: success })
      end
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :description)
  end

end

# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.includes(:questions).all
  end

  def destroy
    Category.find_by(id: params[:id])&.destroy

    redirect_to admin_categories_path
  end
end

# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.includes(:questions).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    Category.find_by(id: params[:id])&.destroy

    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category)
          .permit(:name, :target_score)
  end
end

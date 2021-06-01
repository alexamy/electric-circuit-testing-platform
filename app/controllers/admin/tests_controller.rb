# frozen_string_literal: true

class Admin::TestsController < Admin::BaseController
  def index
    @categories = Test.includes(:questions).all
  end

  def new
    @category = Test.new
  end

  def create
    @category = Test.new(category_params)

    if @category.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def edit
    @category = Test.find(params[:id])
  end

  def update
    @category = Test.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def destroy
    Test.find_by(id: params[:id])&.destroy

    redirect_to admin_tests_path
  end

  private

  def category_params
    params.require(:test)
          .permit(:name, :target_score)
  end
end

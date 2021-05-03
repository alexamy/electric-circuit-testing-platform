# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.includes(:questions).all
  end
end

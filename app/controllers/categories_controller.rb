# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end
end

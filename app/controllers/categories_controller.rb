# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index_with_questions
    @categories = Category.joins(:questions).distinct

    render :index
  end
end

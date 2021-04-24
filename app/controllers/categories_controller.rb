# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index_with_questions
    @categories = Category.with_questions

    render :index
  end
end

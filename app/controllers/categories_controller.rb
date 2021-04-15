# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @question = Question.find(random_question_id)
    @static_question = StaticQuestion.generate_from(@question)
    @static_question.user = current_user

    @static_question.save
  end

  private

  def random_question_id
    Question.where(category: @category).pluck(:id).sample
  end
end

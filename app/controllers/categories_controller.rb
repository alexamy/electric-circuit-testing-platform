# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @question = Question.find(random_question_id)
    create_static_question
  end

  private

  def random_question_id
    Question.where(category: @category).pluck(:id).sample
  end

  def create_static_question
    @static_question = StaticQuestion.new_from(@question)
    @static_question.user = current_user
    @static_question.save
  end
end

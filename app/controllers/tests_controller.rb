# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @categories = Category.joins(:questions).distinct
  end

  def show
    @category = Category.find(params[:id])
    @question = Question.find(random_question_id)
    create_static_question
  end

  # NOTE
  # dont use `redirect_to test_path(@static_question.question.category)`, because
  # in the future test might be the collection of questions from any categories
  def answer
    @static_question = StaticQuestion.find(params[:id])
    head :forbidden and return unless current_user.author_of?(@static_question)

    @static_question.update(user_answer: params[:answer])

    if params[:send_and_quit]
      redirect_to tests_path, notice: t('.test_end')
    else
      @category = Category.find(params[:test_id])
      redirect_to test_path(@category)
    end
  end

  private

  def random_question_id
    Question.where(category: @category).pluck(:id).sample
  end

  def create_static_question
    @static_question = StaticQuestion.new_from(@question)
    @static_question.update(author: current_user)
  end
end

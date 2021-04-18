# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @categories = Category.joins(:questions).distinct
  end

  def show
    @category = Category.find(params[:id])
    @question = Question.find(random_question_id)

    # calculated before creating question, to exclude it from score
    @score = @category.score_of(current_user)
    create_static_question
  end

  def answer
    @static_question = StaticQuestion.find(params[:id])
    can_update = @static_question.user_answer.nil? && current_user.author_of?(@static_question)
    head :forbidden and return unless can_update

    @static_question.update(user_answer: params[:answer])
    redirect_after_answer
  end

  private

  def random_question_id
    Question.where(category: @category).pluck(:id).sample
  end

  def create_static_question
    @static_question = StaticQuestion.new_from(@question)
    @static_question.update(author: current_user)
  end

  # NOTE
  # dont use `redirect_to test_path(@static_question.question.category)`, because
  # in the future *test* might be the collection of questions from any categories
  def redirect_after_answer
    if params[:send_and_quit]
      redirect_to tests_path, notice: t('.test_end')
    else
      @category = Category.find(params[:test_id])
      redirect_to test_path(@category)
    end
  end
end

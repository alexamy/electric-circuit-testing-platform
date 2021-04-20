# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @categories = Category.joins(:questions).distinct
  end

  def start
    @category = Category.find(params[:category_id])
    @test_attempt = TestAttempt.create(category: @category)

    redirect_to next_question_test_attempt_path(@test_attempt)
  end

  def show
    @test_attempt = TestAttempt.find(params[:id])
    @category = @test_attempt.category

    # calculated before creating question, to exclude it from score
    @score = @category.score_of(current_user)
    create_static_question
  end

  def answer
    @static_question = StaticQuestion.find(params[:id])
    return if @static_question.user_answer
    return unless current_user.author_of?(@static_question)

    @static_question.update(user_answer: params[:answer])
    redirect_after_answer
  end

  private

  def random_question_id
    Question.where(category: @test_attempt.category).pluck(:id).sample
  end

  def create_static_question
    @question = Question.find(random_question_id)
    @static_question = StaticQuestion.new_from(@question)
    @static_question.update(author: current_user, test_attempt: @test_attempt)
  end

  # NOTE: dont use `redirect_to test_path(@static_question.question.category)`, because
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

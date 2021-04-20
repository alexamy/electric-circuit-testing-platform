# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @categories = Category.joins(:questions).distinct
  end

  def start
    @category = Category.find(params[:category_id])
    @test_attempt = TestAttempt.create(category: @category, author: current_user)

    redirect_to next_question_test_attempt_path(@test_attempt)
  end

  def next_question
    return unless find_test_attempt

    @category = @test_attempt.category

    # calculated before creating question, to exclude it from score
    @score = @category.score_of(current_user)
    create_static_question
  end

  def answer
    @static_question = StaticQuestion.find(params[:question_id])
    return unless owned?(@static_question)
    return if @static_question.user_answer

    @static_question.update(user_answer: params[:answer])
    redirect_after_answer
  end

  private

  def random_question_id
    Question.where(category: @test_attempt.category).pluck(:id).sample
  end

  def find_test_attempt
    @test_attempt = TestAttempt.find(params[:id])
    return unless owned?(@test_attempt)
    return unless @test_attempt.latest?

    @test_attempt
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
      redirect_to next_question_test_attempt_path(@static_question.test_attempt)
    end
  end
end

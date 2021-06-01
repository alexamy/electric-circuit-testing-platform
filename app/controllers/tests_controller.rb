# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!

  skip_before_action :authenticate_user!, only: [:index]

  def index
    @tests = Test.with_questions
  end

  def start
    @test = Test.find(params[:test_id])
    redirect_to tests_path, notice: t('.already_passed') and return if @test.passed?(current_user)

    @test_attempt = TestAttempt.create(test: @test, author: current_user)
    redirect_to next_question_test_attempt_path(@test_attempt)
  end

  def next_question
    return unless find_test_attempt

    @test = @test_attempt.test
    redirect_to tests_path, notice: t('.passed') and return if @test.passed?(current_user)

    @score = @test.score_of(current_user) # calculated before creating question, to exclude it from score
    create_static_question
  end

  private

  def random_question_id
    Question.where(test: @test_attempt.test).pluck(:id).sample
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
end

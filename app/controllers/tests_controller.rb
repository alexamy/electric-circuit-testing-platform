# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tests = Test.with_questions.order(:name)
  end

  def start
    @test = Test.find(params[:test_id])
    redirect_to tests_path, notice: t('.already_passed') and return if @test.passed?(current_user)

    @attempt = Attempt.create(test: @test, author: current_user)
    redirect_to next_question_attempt_path(@attempt)
  end

  def next_question
    head :forbidden and return unless find_attempt

    @test = @attempt.test
    redirect_to tests_path, notice: t('.passed') and return if @test.passed?(current_user)

    @score = @test.score_of(current_user) # calculated before creating question, to exclude it from score
    create_task
  end

  private

  def random_question_id
    Question.where(test: @attempt.test).pluck(:id).sample
  end

  def find_attempt
    @attempt = Attempt.find(params[:id])
    return unless owned?(@attempt)
    return unless @attempt.latest?

    @attempt
  end

  def create_task
    @question = Question.find(random_question_id)
    @task = Task.new_from(@question)
    @task.update(author: current_user, attempt: @attempt)
  end
end

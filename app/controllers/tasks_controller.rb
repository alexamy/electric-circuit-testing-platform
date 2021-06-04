# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!

  def answer
    return unless find_question

    @task.update(user_answer: params[:answer]) unless @task.expired?
    redirect_after_answer
  end

  private

  def find_question
    @task = Task.find(params[:id])
    return unless owned?(@task)
    return if @task.user_answer

    @task
  end

  def redirect_after_answer
    if params[:send_and_quit]
      redirect_to tests_path, notice: t('.test_end')
    else
      redirect_to next_question_attempt_path(@task.attempt)
    end
  end
end

# frozen_string_literal: true

class StaticQuestionsController < ApplicationController
  before_action :authenticate_user!

  def answer
    return unless find_question

    @static_question.update(user_answer: params[:answer]) unless @static_question.expired?
    redirect_after_answer
  end

  private

  def find_question
    @static_question = Task.find(params[:id])
    return unless owned?(@static_question)
    return if @static_question.user_answer

    @static_question
  end

  def redirect_after_answer
    if params[:send_and_quit]
      redirect_to tests_path, notice: t('.test_end')
    else
      redirect_to next_question_attempt_path(@static_question.attempt)
    end
  end
end

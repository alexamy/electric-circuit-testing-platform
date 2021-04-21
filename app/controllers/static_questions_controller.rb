# frozen_string_literal: true

class StaticQuestionsController < ApplicationController
  before_action :authenticate_user!

  def answer
    @static_question = StaticQuestion.find(params[:id])
    return unless owned?(@static_question)
    return if @static_question.user_answer

    @static_question.update(user_answer: params[:answer])
    redirect_after_answer
  end

  private

  def redirect_after_answer
    if params[:send_and_quit]
      redirect_to tests_path, notice: t('.test_end')
    else
      redirect_to next_question_test_attempt_path(@static_question.test_attempt)
    end
  end
end
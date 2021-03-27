# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    FormulaValidator.call(params.dig(:question, :formula_text))
  end

  private

  def question_params
    params.require(:question).allow(:formula_text)
  end
end

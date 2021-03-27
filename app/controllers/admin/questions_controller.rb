# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
    # @question.formula_parameters.new
  end

  def create
    FormulaValidator.call(params.dig(:question, :formula_text))
  end

  private

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
  end
end

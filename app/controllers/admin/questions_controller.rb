# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
    # @question.formula_parameters.new
  end

  def create
    text = params.dig(:question, :formula_text)
    valid = FormulaValidator.call(text)
    redirect_to new_admin_question_path, alert: t(".formula_error") and return unless valid

    info = FormulaParser.call(text)
  end

  private

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
  end
end

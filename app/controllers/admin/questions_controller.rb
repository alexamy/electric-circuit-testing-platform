# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    return unless validate_formula

    prepare_parameters
  end

  private

  def validate_formula
    text = params.dig(:question, :formula_text)
    valid = FormulaValidator.call(text)
    @alert = t(".formula_error") unless valid
    valid
  end

  def prepare_parameters
    text = params.dig(:question, :formula_text)
    @question = Question.new(question_params.except(:formula_parameters_attributes))
    formula = FormulaParser.call(text)

    formula[:dependencies].each do |name|
      @question.formula_parameters.new(name: name)
    end
  end

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
  end
end

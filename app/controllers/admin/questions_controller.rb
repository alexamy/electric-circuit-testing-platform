# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    return unless valid_formula?
    prepare_parameters and return if params.dig(:question, :formula_parameters_attributes).blank?

    @question = Question.new(question_params)
    @question.formula = FormulaParser.call(@question.formula_text)
    redirect_to admin_question_path(@question), notice: t(".successful") if @question.save
  end

  private

  def valid_formula?
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
          .permit(:text, :comment, :formula_text, :category_id,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
  end
end

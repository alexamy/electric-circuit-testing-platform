# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    return unless valid_formula?
    prepare_parameters and return unless formula_parameters_attributes?

    @question = Question.new(question_params)
    @question.formula = FormulaParser.call(@question.formula_text)
    redirect_to admin_question_path(@question), notice: t('.successful') if @question.save
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @static_question = StaticQuestion.new_from(@question)
  end

  private

  def formula_parameters_attributes?
    params.dig(:question, :formula_parameters_attributes).present?
  end

  def valid_formula?
    text = params.dig(:question, :formula_text)
    valid = FormulaValidator.call(text)
    @alert = t('.formula_error') unless valid
    valid
  end

  def prepare_parameters
    text = params.dig(:question, :formula_text)
    formula = FormulaParser.call(text)

    @question = Question.new(question_params.except(:formula_parameters_attributes))
    formula[:dependencies].each do |name|
      @question.formula_parameters.new(name: name)
    end
  end

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text, :precision, :answer_unit, :category_id, :scheme,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
          .merge(author_id: current_user.id)
  end
end

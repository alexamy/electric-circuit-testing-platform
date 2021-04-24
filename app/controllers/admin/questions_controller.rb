# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  # :reek:DuplicateMethodCall
  def create
    @question = Question.new(question_params)
    render :new and return unless prepare_question

    if @question.save
      redirect_to admin_question_path(@question), notice: t('.successful')
    else
      render :new
    end
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
    flash.now[:alert] = t('.formula_error') unless valid
    valid
  end

  def prepare_question
    return unless valid_formula?
    prepare_parameters and return unless formula_parameters_attributes?

    @question.formula = FormulaParser.call(@question.formula_text)
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
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :category_id,
                  formula_parameters_attributes: %i[name minimum maximum step unit])
          .merge(author_id: current_user.id)
  end
end

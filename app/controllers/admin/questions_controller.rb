# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  # :reek:DuplicateMethodCall
  def create
    @question = Question.new(question_params)
    render :new and return unless valid_formula?

    @question.formula = Formula::Parser.call(@question.formula_text)

    if @question.save
      prepare_parameters
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

  def valid_formula?
    text = params.dig(:question, :formula_text)
    valid = Formula::Validator.call(text)
    flash.now[:alert] = t('.formula_error') unless valid

    valid
  end

  def prepare_parameters
    @question.formula['dependencies'].each do |name|
      @question.formula_parameters.create(name: name, **Formula::Parameter.call(name))
    end
  end

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :category_id)
          .merge(author_id: current_user.id)
  end
end

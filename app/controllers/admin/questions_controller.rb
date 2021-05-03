# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def create
    @question = Question.new(question_params)
    render :new and return unless valid_formula?

    @question.formula = Formula::Parser.call(@question.formula_text)
    render :new and return unless @question.save

    create_parameters
    redirect_to admin_question_edit_parameters_path(@question), notice: t('.successful')
  end

  def index
    @questions = Question.includes(:category).all
  end

  def show
    @question = Question.find(params[:id])
    @static_question = StaticQuestion.new_from(@question)
  end

  def destroy
    Question.find(params[:id]).destroy

    redirect_to admin_questions_path
  end

  private

  def valid_formula?
    valid = Formula::Validator.call(@question.formula_text)
    flash.now[:alert] = t('.formula_error') unless valid

    valid
  end

  def create_parameters
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

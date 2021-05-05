# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def create
    @question = Question.new(question_params)
    render :new and return unless valid_formula?(@question.formula_text)

    @question.formula = Formula::Parser.call(@question.formula_text)
    render :new and return unless @question.save

    create_parameters
    redirect_to admin_question_edit_parameters_path(@question), notice: t('.successful')
  end

  def edit
    @question = Question.find(params[:id])
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  # rubocop:disable Metrics/AbcSize
  def update
    @question = Question.find(params[:id])
    formula_text = question_params[:formula_text]

    render :edit and return unless valid_formula?(formula_text)

    if @question.update(**question_params, formula: Formula::Parser.call(formula_text))
      redirect_to admin_question_edit_parameters_path(@question) and return if update_parameters

      redirect_to admin_questions_path, notice: t('.successful')
    else
      render :edit
    end
  end
  # rubocop:enable Metrics/AbcSize

  def index
    @questions = Question.includes(:category).all
  end

  def show
    @question = Question.find(params[:id])
    @static_question = StaticQuestion.new_from(@question)
  end

  def destroy
    Question.find_by(id: params[:id])&.destroy

    redirect_to admin_questions_path
  end

  private

  def valid_formula?(formula_text)
    valid = Formula::Validator.call(formula_text)
    flash.now[:alert] = t('.formula_error') unless valid

    valid
  end

  def create_parameters
    @question.formula['dependencies'].each do |name|
      @question.formula_parameters.create(name: name, **Formula::Parameter.call(name))
    end
  end

  # :reek:TooManyStatements
  # :reek:FeatureEnvy - TODO move to formula_parameters controller
  # rubocop:disable Metrics/AbcSize
  def update_parameters
    dependencies = @question.formula['dependencies']

    parameters = @question.formula_parameters
    parameter_names = parameters.map(&:name)
    return if parameter_names.sort == dependencies.sort

    parameters.reject { |parameter| dependencies.include?(parameter.name) }.each(&:destroy)

    dependencies.reject { |name| parameter_names.include?(name) }.each do |name|
      parameters.create(name: name, **Formula::Parameter.call(name))
    end
  end
  # rubocop:enable Metrics/AbcSize

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :category_id)
          .merge(author_id: current_user.id)
  end
end

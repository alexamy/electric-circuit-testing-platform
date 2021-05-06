# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    render :new and return unless valid_formula?(@question.formula_text)

    if @question.save
      redirect_to admin_question_edit_parameters_path(@question), notice: t('.successful')
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    formula_text = question_params[:formula_text]

    render :edit and return unless valid_formula?(formula_text)

    new_formula = formula_text != @question.formula_text

    if @question.update(question_params)
      redirect_to admin_question_edit_parameters_path(@question) and return if new_formula

      redirect_to admin_questions_path, notice: t('.successful')
    else
      render :edit
    end
  end

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

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :category_id)
          .merge(author_id: current_user.id)
  end
end

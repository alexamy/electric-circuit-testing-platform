# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

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
    @question.attributes = question_params
    formula_text_changed = @question.formula_text_changed?

    if @question.save
      redirect_to admin_question_edit_parameters_path(@question) and return if formula_text_changed

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

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :category_id)
          .merge(author_id: current_user.id)
  end
end

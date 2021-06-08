# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save && @question.create_parameters
      redirect_to edit_admin_question_parameters_path(@question), notice: t('.successful')
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
    redirect_path = update_redirect_path

    if @question.save
      redirect_to redirect_path, notice: t('.successful')
    else
      render :edit
    end
  end

  def index
    @questions = Question.includes(:test).all
  end

  def show
    @question = Question.find(params[:id])
    @task = Task.new_from(@question)
  end

  def destroy
    Question.find_by(id: params[:id])&.destroy

    redirect_to admin_questions_path
  end

  private

  # NB: call before @question.save
  def update_redirect_path
    if @question.formula_text_changed?
      edit_admin_question_parameters_path(@question)
    else
      admin_questions_path
    end
  end

  def question_params
    params.require(:question)
          .permit(:text, :comment, :formula_text,
                  :precision, :answer_unit, :completion_time,
                  :scheme, :test_id)
          .merge(author_id: current_user.id)
  end
end

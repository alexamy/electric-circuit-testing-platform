# frozen_string_literal: true

# NB: This controller is used for bulk parameters processing

class Teacher::ParametersController < Teacher::BaseController
  before_action :find_question

  def edit; end

  def update
    flash.now[:notice] = t('.successful') if @question.update(parameters_params)
    render :edit
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def parameters_params
    params.require(:question)
          .permit(parameters_attributes: %i[id minimum maximum step unit])
  end
end

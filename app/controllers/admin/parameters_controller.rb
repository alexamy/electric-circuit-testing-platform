# frozen_string_literal: true

class Admin::ParametersController < Admin::BaseController
  def edit_bulk
    find_question
  end

  def update_bulk
    find_question

    flash.now[:notice] = t('.successful') if @question.update(parameters_params)
    render :edit_bulk
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

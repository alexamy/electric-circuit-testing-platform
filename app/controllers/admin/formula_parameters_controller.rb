# frozen_string_literal: true

class Admin::FormulaParametersController < Admin::BaseController
  def edit_bulk
    find_question
  end

  def update_bulk
    find_question

    render :edit_bulk
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def parameters_params
    params.require(:question)
          .permit(formula_parameters_attributes: %i[name minimum maximum step unit])
  end
end

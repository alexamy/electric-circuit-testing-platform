# frozen_string_literal: true

class Admin::FormulaParametersController < Admin::BaseController
  def edit_bulk
    @question = Question.find(params[:question_id])
  end

  def update_bulk; end
end

# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  def new
    @question = Question.new
  end
end

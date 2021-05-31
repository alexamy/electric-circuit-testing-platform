# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def student
    @tests = Category.all
    @attempts = TestAttempt.all.where(author: current_user)
    # test.questions.includes(:static_questions).map(&:static_questions).flatten
  end
end

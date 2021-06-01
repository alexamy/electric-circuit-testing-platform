# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def student
    @user = current_user
    @reports = Category.all.map { |test| Report::Student.new(current_user, test) }
  end
end

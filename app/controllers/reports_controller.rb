# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def student
    @tests = Category.all
  end
end

# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def student
    find_user
    @reports = Category.all.map { |test| Report::Student.new(current_user, test) }
  end

  private

  # :reek:DuplicateMethodCall
  def find_user
    @user = current_user
    return unless params[:id]

    @user = User.find(params[:id]) if current_user.admin?
  end
end

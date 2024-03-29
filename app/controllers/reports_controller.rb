# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def student
    @reports = Test.all.map { |test| Report::Student.new(@user, test) }
  end

  def test
    head :no_content and return unless find_test

    reports = Report::Task.answers(@user, @test).map { |answer| Report::Task.new(answer) }
    @reports = Kaminari.paginate_array(reports).page(params[:page]).per(10)
  end

  private

  # :reek:DuplicateMethodCall
  def find_user
    @user = current_user
    return unless params[:id]

    @user = User.find(params[:id]) if current_user.teacher?
  end

  def find_test
    @test = Test.find_by(id: params[:test_id])
  end
end

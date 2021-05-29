# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view his report', "
  In order to know his progress on all tests
  As an authenticated student
  I'd like to be able to view report of all tests
" do
  scenario 'Unauthenticated user cant view report' do
    visit reports_path

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

  scenario 'Student can view report'
  scenario 'Student cant view report of other students'
  scenario 'Admin can view report of all students'
  scenario 'Report has data only for current student'
end

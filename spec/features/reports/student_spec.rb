# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view his report', "
  In order to know his progress on all tests
  As an authenticated student
  I'd like to be able to view report of all tests
" do
  given(:admin) { create(:admin) }
  given(:student) { create(:student) }

  scenario 'Unauthenticated user cant view report' do
    visit reports_path

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

  describe 'Student' do
    background { sign_in(student) }

    scenario 'can view report' do
      visit reports_path
    end

    scenario 'cant view report of other students'
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'can view report of all students'
  end

  describe 'Report' do
    scenario 'has data only for current student'
  end
end

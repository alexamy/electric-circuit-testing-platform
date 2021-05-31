# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view his report', "
  In order to know his progress on all tests
  As an authenticated student
  I'd like to be able to view report of all tests
" do
  given(:admin) { create(:admin) }
  given(:student) { create(:student) }

  given!(:test) { create(:category, name: 'Test example', target_score: 6) }
  given!(:test_attempt) { create(:test_attempt, category: test, author: student) }
  given!(:question) { create(:question, category: test) }
  given!(:answer) { create(:static_question, :correct, question: question, test_attempt: test_attempt, author: student) }
  given!(:answer_wrong) { create(:static_question, :wrong, question: question, test_attempt: test_attempt, author: student) }

  scenario 'Unauthenticated user cant view report' do
    visit reports_path

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

  describe 'Student' do
    background do
      sign_in(student)
      visit reports_path
    end

    scenario 'can view report' do
      expect(page).to have_content 'Test example'
    end

    scenario 'can view tries count' do
      within '.tries-count' do
        expect(page).to have_content '1'
      end
    end

    scenario 'can view score' do
      within '.score' do
        expect(page).to have_content '1'
      end
    end

    xscenario 'can view correctness percentage' do
      within '.correctness-percentage' do
        expect(page).to have_content '50%'
      end
    end
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'can view report of all students'
  end

  describe 'Report' do
    scenario 'has data only for current student'
  end
end

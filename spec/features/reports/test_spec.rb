# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view report for test', "
  In order to know his progress in the specific test
  As an authenticated student
  I'd like to be able to view report of the test
" do
  given(:admin) { create(:admin) }
  given(:student) { create(:student, email: 'js@example.com', first_name: 'John', last_name: 'Smith') }

  given!(:test) { create(:test, name: 'Test example', target_score: 6) }
  given!(:test_empty) { create(:test, name: 'Test example empty') }
  given!(:question) { create(:question, text: 'Sample question', test: test) }

  given!(:attempt) { create(:attempt, test: test, author: student) }
  given!(:answer) { create(:static_question, :correct, question: question, attempt: attempt, author: student) }
  given!(:answer_wrong) { create(:static_question, :wrong, question: question, attempt: attempt, author: student) }

  given!(:attempt_admin) { create(:attempt, test: test, author: admin) }
  given!(:answers_admin) { create_list(:static_question, 5, :correct, question: question, attempt: attempt_admin, author: admin) }

  scenario 'Unauthenticated user cant view report' do
    visit reports_student_path

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

  describe 'Student' do
    before do
      sign_in(student)

      visit reports_student_path
      click_on 'Test example'
    end

    scenario 'can open report page' do
      expect(page).to have_content 'Отчёт по тесту'
    end

    scenario 'can see answers from all attempts' do
      expect(all('tr.answer').count).to eq 2
    end

    scenario 'can see question text' do
      expect(page).to have_content 'Sample question'
    end

    scenario 'can see generated task conditions'

    scenario 'can see right answer'

    scenario 'can see his answer'

    scenario 'can see if his answer is correct'

    scenario 'can see task creation date and time'

    scenario 'can see answer date and time'

    scenario 'can see scheme in popup window'
  end

  describe 'Admin' do
    scenario 'can view report of a specific student'

    scenario 'can delete static question'
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view his report', "
  In order to know his progress on all tests
  As an authenticated student
  I'd like to be able to view report of all tests
" do
  given(:admin) { create(:admin) }
  given(:student) { create(:student, email: 'js@example.com', first_name: 'John', last_name: 'Smith') }

  given!(:test) { create(:category, name: 'Test example', target_score: 6) }
  given!(:test_attempt) { create(:test_attempt, category: test, author: student) }
  given!(:question) { create(:question, category: test) }
  given!(:answer) { create(:static_question, :correct, question: question, test_attempt: test_attempt, author: student) }
  given!(:answer_wrong) { create(:static_question, :wrong, question: question, test_attempt: test_attempt, author: student) }

  given!(:test_attempts_admin) { create_list(:test_attempt, 5, category: test, author: admin) }

  scenario 'Unauthenticated user cant view report' do
    visit reports_student_path

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

  describe 'Student' do
    background do
      sign_in(student)
      visit reports_student_path
    end

    scenario 'can go to report page through navigation bar' do
      click_on 'Статистика'

      expect(page).to have_content 'Отчёт по темам'
    end

    scenario 'can see his email' do
      expect(page).to have_content 'js@example.com'
    end

    scenario 'can see his name' do
      expect(page).to have_content 'John Smith'
    end

    scenario 'can view report' do
      expect(page).to have_content 'Test example'
    end

    scenario 'can view attempts count' do
      within '.attempts-count' do
        expect(page).to have_content '1'
      end
    end

    scenario 'can view score' do
      within '.score' do
        expect(page).to have_content '1'
      end
    end

    scenario 'can view correctness percentage' do
      within '.correctness-percentage' do
        expect(page).to have_content '50%'
      end
    end

    scenario 'can view target score' do
      within '.target-score' do
        expect(page).to have_content '6'
      end
    end
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'can view report of all students' do
      visit admin_reports_student_path(student)

      expect(page).to have_content 'John Smith'
    end

    scenario 'can view report through link on users page' do
      visit admin_students_path

      within ".student-#{student.id}" do
        click_on 'Статистика'
      end

      expect(page).to have_content 'Отчёт по темам'
      expect(page).to have_content 'John Smith'
    end
  end
end

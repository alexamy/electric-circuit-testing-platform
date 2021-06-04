# frozen_string_literal: true

require 'rails_helper'

feature 'Student can view his report', "
  In order to know his progress on all tests
  As an authenticated student
  I'd like to be able to view report of all tests
" do
  given(:admin) { create(:admin) }
  given(:student) { create(:student, email: 'js@example.com', first_name: 'John', last_name: 'Smith') }

  given!(:test) { create(:test, name: 'Test example', target_score: 6) }
  given!(:test_empty) { create(:test, name: 'Test example empty') }
  given!(:question) { create(:question, test: test) }

  given!(:attempt) { create(:attempt, test: test, author: student) }
  given!(:answer) { create(:task, :correct, question: question, attempt: attempt, author: student) }
  given!(:answer_wrong) { create(:task, :wrong, question: question, attempt: attempt, author: student) }

  given!(:attempt_admin) { create(:attempt, test: test, author: admin) }
  given!(:answers_admin) { create_list(:task, 5, :correct, question: question, attempt: attempt_admin, author: admin) }

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
      expect(page).to have_content 'Smith John'
    end

    scenario 'can view report' do
      expect(page).to have_content 'Test example'
    end

    scenario 'can view attempts count' do
      within ".test-#{test.id} .attempts-count" do
        expect(page).to have_content '1'
      end
    end

    scenario 'can view score' do
      within ".test-#{test.id} .score" do
        expect(page).to have_content '1'
      end
    end

    scenario 'can view answers count' do
      within ".test-#{test.id} .answer-count" do
        expect(page).to have_content '2'
      end
    end

    scenario 'can view correctness percentage' do
      within ".test-#{test.id} .correctness-percentage" do
        expect(page).to have_content '50%'
      end
    end

    scenario 'can view target score' do
      within ".test-#{test.id} .target-score" do
        expect(page).to have_content '6'
      end
    end

    scenario 'sees 0% when no answers given' do
      within ".test-#{test_empty.id}" do
        expect(page).to have_content '0%'
      end
    end
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'can view report of all students' do
      visit admin_reports_student_path(student)

      expect(page).to have_content 'Smith John'
    end

    scenario 'can view report through link on users page' do
      visit admin_students_path

      within ".student-#{student.id}" do
        click_on 'Статистика'
      end

      expect(page).to have_content 'Отчёт по темам'
      expect(page).to have_content 'Smith John'
    end
  end
end

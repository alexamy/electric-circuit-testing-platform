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
  given!(:question) { create(:question, text: 'Sample question', completion_time: 60, test: test) }

  given!(:attempt) { create(:attempt, test: test, author: student) }

  given!(:answer_wrong) do
    create(:static_question, :wrong, question: question, attempt: attempt, author: student,
                                     created_at: Time.zone.local(2021, 1, 31, 12, 18, 0))
  end

  given!(:answer_empty) do
    create(:static_question, question: question, attempt: attempt, author: student,
                             created_at: Time.zone.local(2021, 1, 31, 12, 18, 59))
  end

  given!(:answer) do
    create(:static_question, :correct, question: question, attempt: attempt, author: student,
                                       created_at: Time.zone.local(2021, 1, 31, 12, 15, 0),
                                       updated_at: Time.zone.local(2021, 1, 31, 12, 16, 15))
  end

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
      expect(all('tr.answer').count).to eq 3
    end

    scenario 'can see all answers ordered by creation date' do
      expect(all('.created-at').map(&:text)).to eq [
        '12:15:00 31.01.21',
        '12:18:00 31.01.21',
        '12:18:59 31.01.21'
      ]
    end

    scenario 'see only tasks with expired answer time' do
      # 3 seconds after task creation
      Timecop.freeze(Time.zone.local(2021, 1, 31, 12, 19, 2)) do
        expect(page).not_to have_content '12:18:59 31.01.21'
        expect(all('tr.answer').count).to eq 2
      end
    end

    describe 'in each task' do
      scenario 'can see question text' do
        expect(page).to have_content 'Sample question'
      end

      scenario 'can see generated task arguments' do
        within ".answer-#{answer.id} .arguments" do
          expect(page).to have_content 'I = 1 R = 1'
        end
      end

      scenario 'can see correct answer' do
        within ".answer-#{answer.id} .correct-answer" do
          expect(page).to have_content '1'
        end
      end

      scenario 'can see his answer' do
        within ".answer-#{answer_wrong.id} .user-answer" do
          expect(page).to have_content '2'
        end
      end

      scenario 'can see hypnen as no answer' do
        within ".answer-#{answer_empty.id} .user-answer" do
          expect(page).to have_content '-'
        end
      end

      scenario 'can see if his answer is correct' do
        expect(page).to have_css ".answer-#{answer.id}.bg-green-100"
      end

      scenario 'can see if his answer is wrong' do
        expect(page).to have_css ".answer-#{answer_wrong.id}.bg-red-100"
      end

      scenario 'can see task creation datetime' do
        within ".answer-#{answer.id} .created-at" do
          expect(page).to have_content '12:15:00 31.01.21'
        end
      end

      scenario 'can see answer duration' do
        within ".answer-#{answer.id} .answer-duration" do
          expect(page).to have_content '01:15'
        end
      end

      scenario 'can see hypnen as answer duration if no answer' do
        within ".answer-#{answer_empty.id} .answer-duration" do
          expect(page).to have_content '-'
        end
      end

      scenario 'can see scheme' do
        expect(page).to have_selector "td[data-tooltip-image='#{rails_blob_path(question.scheme)}']"
      end
    end
  end

  describe 'Admin' do
    before do
      sign_in(admin)
      visit admin_students_path

      within(".student-#{student.id}") { click_on 'Статистика' }
      click_on 'Test example'
    end

    scenario 'can view report of a specific student' do
      expect(page).to have_content 'Smith John'
    end
  end
end

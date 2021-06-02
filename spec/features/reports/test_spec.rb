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
  given!(:question) { create(:question, test: test) }

  given!(:attempt) { create(:attempt, test: test, author: student) }
  given!(:answer) { create(:static_question, :correct, question: question, attempt: attempt, author: student) }
  given!(:answer_wrong) { create(:static_question, :wrong, question: question, attempt: attempt, author: student) }

  given!(:attempt_admin) { create(:attempt, test: test, author: admin) }
  given!(:answers_admin) { create_list(:static_question, 5, :correct, question: question, attempt: attempt_admin, author: admin) }

  scenario 'Unauthenticated user cant view report'

  describe 'Student' do
    scenario 'can go to report page through all tests report'

    scenario 'can see answers from all attempts'

    scenario 'can see task name'

    scenario 'can see task creation date and time'

    scenario 'can see answer date and time'

    scenario 'can see generated task conditions'

    scenario 'can see his answer'

    scenario 'can see right answer'
  end

  describe 'Admin' do
    scenario 'can view report of a specific student'
  end
end

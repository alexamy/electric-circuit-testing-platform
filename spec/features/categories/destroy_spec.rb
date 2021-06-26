# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can delete test', "
  In order to git rid of old test
  As an authenticated teacher
  I'd like to be able to delete test
" do
  given(:teacher) { create(:teacher) }
  given(:test) { create(:test) }

  given(:question) { create(:question, test: test) }
  given(:attempt) { create(:attempt, author: teacher, test: test) }
  given!(:task) { create(:task, question: question, attempt: attempt) }

  background { sign_in(teacher) }

  scenario 'Teacher destroys test' do
    visit teacher_tests_path

    within 'table' do
      click_on 'Удалить'

      expect(page).not_to have_content test.name
    end
  end
end

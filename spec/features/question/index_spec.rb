# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can see list of questions', "
  In order to find desired question
  As an authenticated teacher
  I'd like to be able to see list of all questions
" do
  given(:teacher) { create(:teacher) }

  background { sign_in(teacher) }

  describe 'pagination' do
    given!(:questions) { create_list(:question, 11, author: teacher) }

    scenario 'teacher can see paginated report' do
      visit teacher_questions_path

      expect(page).to have_selector 'nav.pagination'
    end
  end
end

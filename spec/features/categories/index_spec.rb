# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can view list of tests', "
  In order to select needed test
  As an authenticated teacher
  I'd like to be able to view list of tests
" do
  given(:teacher) { create(:teacher) }
  given!(:tests) { create_list(:test, 5) }
  given(:test) { tests.first }
  given!(:questions) { create_list(:question, 3, test: test) }

  background { sign_in(teacher) }

  describe 'Teacher views list of tests' do
    scenario 'can see list of tests' do
      visit teacher_tests_path

      tests_on_page = page.all('.test').map(&:text)
      expect(tests_on_page).to match_array tests.map(&:name)
    end

    scenario 'can see question count for test' do
      visit teacher_tests_path

      expect(page).to have_selector 'td', text: questions.size
    end
  end
end

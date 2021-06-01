# frozen_string_literal: true

require 'rails_helper'

feature 'User can view list of tests', "
  In order to start preferable test
  As an unauthenticated user
  I would like to select a test
" do
  given!(:test) { create(:test, name: 'with questions') }
  given!(:test_without_questions) { create(:test, name: 'without questions') }
  given!(:questions) { create_list(:question, 3, test: test) }

  scenario 'User views list of tests' do
    visit tests_path

    expect(page).not_to have_content test_without_questions.name
    expect(page).to have_link test.name, href: start_attempt_path(test)
  end
end

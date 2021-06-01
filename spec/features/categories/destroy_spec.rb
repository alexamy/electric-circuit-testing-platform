# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete test', "
  In order to git rid of old test
  As an authenticated admin
  I'd like to be able to delete test
" do
  given(:admin) { create(:admin) }
  given(:test) { create(:test) }

  given(:question) { create(:question, test: test) }
  given(:test_attempt) { create(:attempt, author: admin, test: test) }
  given!(:static_question) { create(:static_question, question: question, test_attempt: test_attempt) }

  background { sign_in(admin) }

  scenario 'Admin destroys test' do
    visit admin_tests_path

    within 'table' do
      click_on 'Удалить'

      expect(page).not_to have_content test.name
    end
  end
end

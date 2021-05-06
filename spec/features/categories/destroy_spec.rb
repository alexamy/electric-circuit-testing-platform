# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete category', "
  In order to git rid of old category
  As an authenticated admin
  I'd like to be able to delete category
" do
  given(:admin) { create(:admin) }
  given(:category) { create(:category) }

  given(:question) { create(:question, category: category) }
  given(:test_attempt) { create(:test_attempt, author: admin, category: category) }
  given!(:static_question) { create(:static_question, question: question, test_attempt: test_attempt) }

  background { sign_in(admin) }

  scenario 'Admin destroys category' do
    visit admin_categories_path

    within 'table' do
      click_on 'Удалить'

      expect(page).not_to have_content category.name
    end
  end
end

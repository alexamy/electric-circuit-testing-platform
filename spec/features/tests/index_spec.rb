# frozen_string_literal: true

require 'rails_helper'

feature 'User can view list of categories', "
  In order to start preferable test
  As an unauthenticated user
  I would like to select a category
" do
  given!(:category) { create(:category, name: 'with questions') }
  given!(:category_without_questions) { create(:category, name: 'without questions') }
  given!(:questions) { create_list(:question, 3, category: category) }

  scenario 'User views list of categories' do
    visit tests_path

    expect(page).not_to have_content category_without_questions.name
    expect(page).to have_link category.name, href: test_path(category)
  end
end

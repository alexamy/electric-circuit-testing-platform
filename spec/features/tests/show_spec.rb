# frozen_string_literal: true

require 'rails_helper'

feature 'User can start test', "
  In order to pass the test
  As an authenticated user
  I would like to start testing
" do
  given(:category) { create(:category) }
  given(:question) { create(:question, category: category) }

  scenario 'Unauthenticated user tries to start testing' do
    visit test_path(category)
    expect(page).to have_content 'Вам необходимо войти в систему'
  end

  scenario 'Authenticated start testing'
end

# frozen_string_literal: true

require 'rails_helper'

feature 'User can start test', "
  In order to pass the test
  As an authenticated user
  I would like to start testing
" do
  given(:category) { create(:category) }
  given(:questions) { create_list(:question, 5, category: category) }
  given(:user) { create(:user) }

  scenario 'Unauthenticated user tries to start testing' do
    visit test_path(category)

    expect(page).to have_content 'Вам необходимо войти в систему'
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    xscenario 'starts testing' do
      visit test_path(category)

      expect(page).to have_field 'Ответ'
    end
  end
end

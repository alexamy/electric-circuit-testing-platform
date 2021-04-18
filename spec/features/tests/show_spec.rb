# frozen_string_literal: true

require 'rails_helper'

feature 'User can start test', "
  In order to pass the test
  As an authenticated user
  I would like to start testing
" do
  given(:category) { create(:category) }
  given!(:questions) { create_list(:question, 5, category: category) }
  given(:user) { create(:user) }

  scenario 'Unauthenticated user tries to start testing' do
    visit test_path(category)

    expect(page).to have_content 'Вам необходимо войти в систему'
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'starts testing' do
      visit test_path(category)

      expect(page).to have_content 'Схема'
      expect(page).to have_content 'Параметры схемы'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Отправить'
      expect(page).to have_button 'Отправить и выйти'
    end

    scenario 'proceeds to next question' do
      visit test_path(category)

      click_on 'Отправить'

      expect(page).to have_content 'Схема'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Отправить'
    end

    scenario 'exits from testing' do
      visit test_path(category)

      click_on 'Отправить и выйти'

      expect(page).to have_content 'Вы вышли из тестирования'
      expect(page).not_to have_field 'Ответ'
    end

    scenario 'sees his current score'
    scenario 'can answer only in shown time interval'
  end
end

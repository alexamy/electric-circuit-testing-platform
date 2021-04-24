# frozen_string_literal: true

require 'rails_helper'

feature "
  In order to get status information
  As an user
  I'd like to be able to get notifications and interact with them
", js: true do
  describe 'Notification' do
    given(:admin) { create(:admin) }

    background do
      sign_in(admin)
      visit new_admin_question_path

      fill_in 'Формула', with: 'x='
      click_on 'Создать вопрос'
    end

    scenario 'is shown' do
      within '.notifications' do
        expect(page).to have_content 'Ошибка'
      end
    end

    scenario 'hides after some time' do
      PageTimer.tick(10_000)

      within '.notifications' do
        expect(page).not_to have_content 'Ошибка'
      end
    end

    scenario 'hides on close button click' do
      click_on '.notification__close'
      PageTimer.tick(1000)

      within '.notifications' do
        expect(page).not_to have_content 'Ошибка'
      end
    end
  end
end

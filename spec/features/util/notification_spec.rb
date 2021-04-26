# frozen_string_literal: true

require 'rails_helper'

feature "
  In order to get status information
  As an user
  I'd like to be able to get notifications and interact with them
" do
  describe 'Notification', js: true do
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
      PageTimer.tick(5000)

      expect(page).not_to have_content 'Ошибка'
    end

    scenario 'hides on close button click' do
      find('.notification__close').click

      expect(page).not_to have_content 'Ошибка'
    end
  end
end

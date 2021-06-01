# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can create test', "
  In order to add new test
  As an authenticated admin
  I'd like to be able to create test
" do
  given(:admin) { create(:admin) }

  background { sign_in(admin) }

  scenario 'Admin creates test' do
    visit admin_tests_path
    click_on 'Создать'

    fill_in 'Название', with: 'Test'
    fill_in 'Порог для зачета', with: '10'
    click_on 'Сохранить категорию'

    expect(page).to have_selector 'td', text: 'Test'
  end

  describe 'errors' do
    scenario 'Admin creates test with name error' do
      visit admin_tests_path
      click_on 'Создать'

      fill_in 'Название', with: ''
      fill_in 'Порог для зачета', with: '1'
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Название не может быть пустым'
    end

    scenario 'Admin creates test with completion time error' do
      visit admin_tests_path
      click_on 'Создать'

      fill_in 'Название', with: 'Test'
      fill_in 'Порог для зачета', with: '0'
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Порог для зачета может иметь значение большее 0'
    end
  end
end

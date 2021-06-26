# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can create test', "
  In order to add new test
  As an authenticated teacher
  I'd like to be able to create test
" do
  given(:teacher) { create(:teacher) }

  background { sign_in(teacher) }

  scenario 'Teacher creates test' do
    visit teacher_tests_path
    click_on 'Создать'

    fill_in 'Название', with: 'Test'
    fill_in 'Порог для зачета', with: '10'
    click_on 'Сохранить категорию'

    expect(page).to have_selector 'td', text: 'Test'
  end

  describe 'errors' do
    scenario 'Teacher creates test with name error' do
      visit teacher_tests_path
      click_on 'Создать'

      fill_in 'Название', with: ''
      fill_in 'Порог для зачета', with: '1'
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Название не может быть пустым'
    end

    scenario 'Teacher creates test with completion time error' do
      visit teacher_tests_path
      click_on 'Создать'

      fill_in 'Название', with: 'Test'
      fill_in 'Порог для зачета', with: '0'
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Порог для зачета может иметь значение большее 0'
    end
  end
end

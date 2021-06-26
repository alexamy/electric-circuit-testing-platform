# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can edit test', "
  In order to change test data
  As an authenticated teacher
  I'd like to be able to edit test
" do
  given(:teacher) { create(:teacher) }
  given!(:test) { create(:test, name: 'Test', target_score: 10) }

  background { sign_in(teacher) }

  scenario 'Teacher edits test' do
    visit teacher_tests_path

    click_on 'Редактировать'
    fill_in 'Название', with: 'Test'
    fill_in 'Порог для зачета', with: 50
    click_on 'Сохранить категорию'

    expect(page).to have_selector 'td', text: 'Test'
    expect(page).to have_selector 'td', text: 50
  end

  describe 'errors' do
    scenario 'Teacher edits test with name error' do
      visit teacher_tests_path
      click_on 'Редактировать'

      fill_in 'Название', with: ''
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Название не может быть пустым'
    end
  end
end

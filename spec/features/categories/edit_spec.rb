# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit category', "
  In order to change category data
  As an authenticated admin
  I'd like to be able to edit category
" do
  given(:admin) { create(:admin) }
  given!(:category) { create(:category, name: 'Test', target_score: 10) }

  background { sign_in(admin) }

  scenario 'Admin edits category' do
    visit admin_categories_path

    click_on 'Редактировать'
    fill_in 'Название', with: 'TestCategory'
    fill_in 'Порог для зачета', with: 50
    click_on 'Сохранить категорию'

    expect(page).to have_selector 'td', text: 'TestCategory'
    expect(page).to have_selector 'td', text: 50
  end

  describe 'errors' do
    scenario 'Admin edits category with name error' do
      visit admin_categories_path
      click_on 'Редактировать'

      fill_in 'Название', with: ''
      click_on 'Сохранить категорию'

      expect(page).to have_content 'Название не может быть пустым'
    end
  end
end

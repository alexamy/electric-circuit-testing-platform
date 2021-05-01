# frozen_string_literal: true

require 'rails_helper'

feature 'User can create question', "
  In order to fill tests
  As an authenticated admin
  I'd like to be able to create question with formulas
" do
  given(:user) { create(:user) }
  given(:admin) { create(:admin) }
  given!(:category) { create(:category) }

  scenario 'Unauthenticated user cant create question' do
    visit new_admin_question_path

    expect(page).to have_content 'Доступ к ресурсу запрещен'
  end

  scenario 'Student cant create question' do
    sign_in(user)
    visit new_admin_question_path

    expect(page).to have_content 'Доступ к ресурсу запрещен'
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'sees alert when enters invalid formula' do
      visit new_admin_question_path

      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'formula with error'
      click_on 'Создать вопрос'

      expect(page).to have_content 'Ошибка в формуле'
    end

    scenario 'sees validation error' do
      visit new_admin_question_path

      fill_in 'Формула', with: 'V=R'
      click_on 'Создать вопрос'

      expect(page).to have_content('Текст вопроса не может быть пустым')
    end

    scenario 'can create question' do
      visit new_admin_question_path

      select category.name, from: 'Категория'
      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'V=R1'
      fill_in 'Единица измерения ответа', with: 'В'
      fill_in 'Точность', with: '2'
      fill_in 'Максимальное время ответа', with: '2'
      attach_file 'Схема', "#{Rails.root}/spec/support/files/397KB.png"
      click_on 'Создать вопрос'

      expect(page).to have_content 'Вопрос успешно создан'
      expect(page).to have_selector 'img.question-scheme'
    end
  end
end

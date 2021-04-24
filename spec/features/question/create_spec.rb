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

    scenario 'sees alert when enters invalid formula', js: true do
      visit new_admin_question_path

      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'formula with error'
      click_on 'Создать вопрос'

      expect(page).to have_content 'Ошибка в формуле'
      expect(page).to have_field 'Формула', with: 'formula with error'
    end

    scenario 'sees validation error when skip parameter info', js: true do
      visit new_admin_question_path

      fill_in 'Формула', with: 'V=R'
      click_on 'Создать вопрос'
      click_on 'Создать вопрос'

      expect(page).to have_content('Текст вопроса не может быть пустым')
    end

    scenario 'sees parameters form when enters valid formula', js: true do
      visit new_admin_question_path

      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'V=R2/(R1+R2)'

      click_on 'Создать вопрос'

      expect(page).to have_field 'Название', with: 'R1'
      expect(page).to have_field 'Название', with: 'R2'
    end

    scenario 'can create question', js: true do
      visit new_admin_question_path

      select category.name, from: 'Категория'
      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'V=R1'
      fill_in 'Единица измерения ответа', with: 'В'
      fill_in 'Точность', with: '2'

      click_on 'Создать вопрос'

      attach_file 'Схема', "#{Rails.root}/spec/support/files/397KB.png"

      fill_in 'Минимум', with: 10
      fill_in 'Максимум', with: 100
      fill_in 'Шаг', with: 10
      fill_in 'Единица измерения', with: 'В'

      click_on 'Создать вопрос'

      expect(page).to have_content 'Вопрос успешно создан'
      expect(page).to have_selector 'img.question-scheme'
    end
  end
end

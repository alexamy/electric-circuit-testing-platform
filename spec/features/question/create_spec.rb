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
      click_on 'Сохранить вопрос'

      expect(page).to have_content 'Формула содержит ошибки'
    end

    scenario 'sees validation error' do
      visit new_admin_question_path

      fill_in 'Формула', with: 'V=R'
      click_on 'Сохранить вопрос'

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
      click_on 'Сохранить вопрос'

      expect(page).to have_content 'Вопрос успешно создан'
    end

    scenario 'can change parameters default values' do
      visit new_admin_question_path

      select category.name, from: 'Категория'
      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'V=R1'
      fill_in 'Единица измерения ответа', with: 'В'
      fill_in 'Точность', with: '2'
      fill_in 'Максимальное время ответа', with: '2'
      attach_file 'Схема', "#{Rails.root}/spec/support/files/397KB.png"
      click_on 'Сохранить вопрос'

      fill_in 'Минимум', with: '1'
      fill_in 'Максимум', with: '100'
      fill_in 'Шаг', with: '5'
      fill_in 'Единица измерения', with: 'unit'
      click_on 'Сохранить параметры'

      expect(page).to have_content 'Параметры успешно обновлены'
    end

    scenario 'see error when has empty fields' do
      visit new_admin_question_path

      select category.name, from: 'Категория'
      fill_in 'Текст вопроса', with: 'Вычислить показание вольтметра XMM1'
      fill_in 'Формула', with: 'V=R1'
      fill_in 'Единица измерения ответа', with: 'В'
      fill_in 'Точность', with: '2'
      fill_in 'Максимальное время ответа', with: '2'
      attach_file 'Схема', "#{Rails.root}/spec/support/files/397KB.png"
      click_on 'Сохранить вопрос'

      fill_in 'Минимум', with: ''
      fill_in 'Максимум', with: '100'
      fill_in 'Шаг', with: '5'
      fill_in 'Единица измерения', with: 'unit'
      click_on 'Сохранить параметры'

      expect(page).to have_content 'Минимум не может быть пустым'
    end
  end
end

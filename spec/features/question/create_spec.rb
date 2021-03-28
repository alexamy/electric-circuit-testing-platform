# frozen_string_literal: true

require "rails_helper"

feature "User can create question", "
  In order to fill tests
  As an authenticated admin
  I'd like to be able to create question with formulas
" do
  given(:user) { create(:user) }
  given(:admin) { create(:admin) }

  scenario "Unauthenticated user cant create question"

  describe "Admin" do
    background { sign_in(admin) }

    scenario "sees alert when enters invalid formula", js: true do
      visit new_admin_question_path

      fill_in "Текст вопроса", with: "Вычислить показание вольтметра XMM1"
      fill_in "Формула", with: "formula with error"
      click_on "Создать Вопрос"

      expect(page).to have_content "Ошибка в формуле"
      expect(page).to have_field "Формула", with: "formula with error"
    end

    scenario "sees parameters form when enters valid formula", js: true do
      visit new_admin_question_path

      fill_in "Текст вопроса", with: "Вычислить показание вольтметра XMM1"
      fill_in "Формула", with: "V=R2/(R1+R2)"

      click_on "Создать Вопрос"

      expect(page).to have_field "Название", with: "R1"
      expect(page).to have_field "Название", with: "R2"
    end

    xscenario "can create question", js: true do
      visit new_admin_question_path

      fill_in "Текст вопроса", with: "Вычислить показание вольтметра XMM1"
      fill_in "Формула", with: "V=R1"

      click_on "Создать Вопрос"

      fill_in "Минимум", with: 10
      fill_in "Максимум", with: 100
      fill_in "Шаг", with: 10
      fill_in "Единица измерения", with: "В"

      click_on "Создать Вопрос"

      expect(page).to have_content "Вопрос успешно создан"
    end
  end
end

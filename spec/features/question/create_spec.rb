# frozen_string_literal: true

require "rails_helper"

feature "User can create question", "
  In order to fill tests
  As an authenticated admin
  I'd like to be able to create question with formulas
" do
  given(:user) { create(:user) }
  given(:admin) { create(:user, :admin) }

  scenario "Unauthenticated user cant create question"

  scenario "Admin creates question" do
    visit new_admin_question_path

    fill_in "Текст", with: "Вычислить показание вольтметра XMM1"
    fill_in "Формула", with: "V=R2/(R1+R2)"

    click_on "Проверить"

    within '.parameter[data-target="R1"]' do
      fill_in "Мин", with: "100"
      fill_in "Макс", with: "1000000"
      fill_in "Шаг", with: "100"
    end

    within '.parameter[data-target="R2"]' do
      fill_in "Мин", with: "100"
      fill_in "Макс", with: "1000000"
      fill_in "Шаг", with: "100"
    end

    click_on "Создать"

    expect(page).to have_content "Вопрос успешно создан."
  end
end

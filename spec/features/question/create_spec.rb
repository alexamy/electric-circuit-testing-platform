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

  scenario "Admin see parameters form when verifying question" do
    visit new_admin_question_path

    fill_in "Текст вопроса", with: "Вычислить показание вольтметра XMM1"
    fill_in "Формула", with: "V=R2/(R1+R2)"

    click_on "Создать Вопрос"

    expect(page).to have_selector('form.parameter[data-target="R1"]')
    expect(page).to have_selector('form.parameter[data-target="R2"]')
  end
end

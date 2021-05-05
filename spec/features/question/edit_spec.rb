# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit question', "
  In order to change question data
  As an authenticated admin
  I'd like to be able to edit question
" do
  given(:admin) { create(:admin) }
  given!(:question) do
    create(:question,
           formula_text: 'x=y',
           formula: { target: 'x', dependencies: %w[y], bodies: { x: 'y' } })
  end

  background { sign_in(admin) }

  scenario 'Admin can edit question fields other than formula' do
    visit admin_questions_path

    click_on 'Редактировать'
    fill_in 'Текст вопроса', with: 'Sample question text'
    click_on 'Сохранить вопрос'

    expect(page).to have_content 'Вопрос успешно сохранен'
    expect(page).to have_selector 'td', text: 'Sample question text'
  end

  scenario 'Admin can edit question formula' do
    visit admin_questions_path

    click_on 'Редактировать'
    fill_in 'Формула', with: 'x=t'
    click_on 'Сохранить вопрос'

    expect(page).not_to have_field 'Название', with: 'y'
    expect(page).to have_field 'Название', with: 't'
  end
end

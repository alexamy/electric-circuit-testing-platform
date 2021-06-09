# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit question parameters', "
  In order to change parameter values
  As an authenticated admin
  I'd like to be able to edit question parameters
" do
  given(:admin) { create(:admin) }

  given(:question_step) do
    create(:question, formula_text: 'x=y', author: admin, parameters: ['y'])
  end

  given(:question_enum) do
    create(:question, formula_text: 'x=y', author: admin,
                      parameters: { 'y' => { factory: :enum_parameter, variants: [1, 2, 3] } })
  end

  background { sign_in(admin) }

  describe 'Step type' do
    scenario 'can see' do
      visit edit_admin_question_parameters_path(question_step)

      expect(page).to have_field 'Минимум'
      expect(page).to have_field 'Максимум'
      expect(page).to have_field 'Шаг'
    end

    scenario 'can edit'
  end

  describe 'Enum type' do
    scenario 'can see' do
      visit edit_admin_question_parameters_path(question_enum)

      expect(page).to have_field 'Варианты', with: '1 2 3'
    end

    scenario 'can edit'
  end

  describe 'Formula type' do
    scenario 'can see'

    scenario 'can edit'
  end
end

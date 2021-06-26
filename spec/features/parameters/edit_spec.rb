# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can edit question parameters', "
  In order to change parameter values
  As an authenticated teacher
  I'd like to be able to edit question parameters
" do
  given(:teacher) { create(:teacher) }

  background { sign_in(teacher) }

  describe 'Step type' do
    given(:question) do
      create(:question, formula_text: 'x=y', author: teacher, parameters: ['y'])
    end

    scenario 'can see' do
      visit edit_teacher_question_parameters_path(question)

      expect(page).to have_field 'Минимум'
      expect(page).to have_field 'Максимум'
      expect(page).to have_field 'Шаг'
    end

    scenario 'can edit'
  end

  describe 'Enum type' do
    given(:question) do
      create(:question, formula_text: 'x=y', author: teacher,
                        parameters: { 'y' => { factory: :enum, variants: [1, 2, 3] } })
    end

    scenario 'can see' do
      visit edit_teacher_question_parameters_path(question)

      expect(page).to have_field 'Варианты', with: '1 2 3'
    end

    scenario 'can edit'
  end

  describe 'Formula type' do
    given(:question) do
      create(:question, formula_text: 'x=y+z', author: teacher,
                        parameters: { 'y' => {}, 'z' => { factory: :formula, formula: 'y*2' } })
    end

    scenario 'can see' do
      visit edit_teacher_question_parameters_path(question)

      expect(page).to have_field 'Формула', with: 'y*2'
    end

    scenario 'can edit'
  end
end

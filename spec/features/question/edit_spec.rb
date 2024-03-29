# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can edit question', "
  In order to change question data
  As an authenticated teacher
  I'd like to be able to edit question
" do
  given(:teacher) { create(:teacher) }

  before { create(:question, formula_text: 'x=y', parameters: %w[y]) }

  background { sign_in(teacher) }

  describe 'Teacher' do
    scenario 'can edit question fields other than formula' do
      visit teacher_questions_path

      click_on 'Редактировать'
      fill_in 'Текст вопроса', with: 'Sample question text'
      click_on 'Сохранить вопрос'

      expect(page).to have_content 'Вопрос успешно сохранен'
      expect(page).to have_selector 'td', text: 'Sample question text'
    end

    scenario 'can edit question formula' do
      visit teacher_questions_path

      click_on 'Редактировать'
      fill_in 'Формула', with: 'x=t'
      click_on 'Сохранить вопрос'

      expect(page).not_to have_field 'Название', with: 'y'
      expect(page).to have_field 'Название', with: 't'
    end

    context 'when question has long text' do
      before do
        create(:question, text: 'На какой угол Y относительно контакта, подключенного к нулевому потенциалу источника питания')
      end

      scenario 'can see shortened version of question text' do
        visit teacher_questions_path

        expect(page).not_to have_content 'На какой угол Y относительно контакта, подключенного к нулевому потенциалу источника питания'
        expect(page).to have_content 'На какой угол Y относительно контакта, подключенного к нулевому потенциалу ис...'
      end
    end
  end
end

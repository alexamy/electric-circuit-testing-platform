# frozen_string_literal: true

require 'rails_helper'

feature 'User can view question', "
  In order to explore questions
  As an authenticated teacher
  I'd like to be able to view questions
" do
  given(:teacher) { create(:teacher) }
  given!(:questions) { create_list(:question, 3, comment: 'question comment') }
  given(:question) { questions.first }
  given(:question_without_scheme) { create(:question, scheme: nil) }
  given(:question_multiline) { create(:question, text: "Line 1\nLine 2") }

  background { sign_in(teacher) }

  describe 'Teacher' do
    scenario 'views question list' do
      visit teacher_questions_path

      questions.each do |question|
        expect(page).to have_content question.id
        expect(page).to have_link question.text, href: teacher_question_path(question)
      end
    end

    scenario 'views question' do
      visit teacher_question_path(question)

      expect(page).to have_content(question.text)
      expect(page).to have_content(question.comment)
      expect(page).to have_content(question.formula_text)
    end

    scenario 'views example of question' do
      visit teacher_question_path(question)

      expect(page).to have_selector '.question-example', text: 'Пример задания'
    end

    scenario 'views question without scheme' do
      visit teacher_question_path(question_without_scheme)

      expect(page).not_to have_selector '.question-scheme'
    end

    scenario 'views question with multiline text' do
      visit teacher_question_path(question_multiline)

      within '.question-text' do
        expect(page).to have_selector 'br'
      end
    end
  end
end

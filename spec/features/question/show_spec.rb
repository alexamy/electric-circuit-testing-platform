# frozen_string_literal: true

require 'rails_helper'

feature 'User can view question', "
  In order to explore questions
  As an authenticated admin
  I'd like to be able to view questions
" do
  given(:admin) { create(:admin) }
  given!(:questions) { create_list(:question, 3, comment: 'question comment') }
  given(:question) { questions.first }

  background { sign_in(admin) }

  scenario 'Admin views question list' do
    visit admin_questions_path

    questions.each do |question|
      expect(page).to have_content question.id
      expect(page).to have_link question.text, href: admin_question_path(question)
    end
  end

  scenario 'Admin views question' do
    visit admin_question_path(question)

    expect(page).to have_content(question.text)
    expect(page).to have_content(question.comment)
    expect(page).to have_content(question.formula_text)
  end

  scenario 'Admin views example of question' do
    visit admin_question_path(question)

    expect(page).to have_selector '.question-example', text: 'Пример задания'
  end
end

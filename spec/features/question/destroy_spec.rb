# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can delete question', "
  In order to git rid of the question
  As an authenticated teacher
  I'd like to be able to delete question
" do
  given(:teacher) { create(:teacher) }
  given!(:question) { create(:question) }

  background { sign_in(teacher) }

  scenario 'Teacher deletes question' do
    visit teacher_questions_path
    click_on 'Удалить'

    expect(page).not_to have_content question.text
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete question', "
  In order to git rid of the question
  As an authenticated admin
  I'd like to be able to delete question
" do
  given(:admin) { create(:admin) }
  given!(:question) { create(:question) }

  background { sign_in(admin) }

  scenario 'Admin deletes question' do
    visit admin_questions_path
    click_on 'Удалить'

    expect(page).not_to have_content question.text
  end
end

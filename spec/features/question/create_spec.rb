# frozen_string_literal: true

require "rails_helper"

feature "User can create question", "
  In order to fill tests
  As an authenticated admin
  I'd like to be able to create question with formulas
" do
  given(:user) { create(:user) }
  given(:admin) { create(:user, :admin) }

  scenario "Unauthenticated user cant create question" do
    visit new_question_path
    expect(page).to have_current_path(root_path)
  end
end

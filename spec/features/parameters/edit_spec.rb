# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit question parameters', "
  In order to change parameter values
  As an authenticated admin
  I'd like to be able to edit question parameters
" do
  given(:admin) { create(:admin) }
  given(:question) do
    create(:question, formula_text: 'x=y', author: admin,
                      parameters: { 'y' => { factory: :enum_parameter, variants: [1, 2, 3] } })
  end

  background { sign_in(admin) }

  describe 'Admin' do
    scenario 'can see enum parameter' do
      visit edit_admin_question_parameters_path(question)

      within '.parameter-variants' do
        expect(page).to have_content '1, 2, 3'
      end
    end
  end
end

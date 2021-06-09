# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can see list of questions', "
  In order to find desired question
  As an authenticated admin
  I'd like to be able to see list of all questions
" do
  given(:admin) { create(:admin) }

  background { sign_in(admin) }

  describe 'pagination' do
    given!(:questions) { create_list(:question, 11, author: admin) }

    scenario 'admin can see paginated report' do
      visit admin_questions_path

      expect(page).to have_selector 'nav.pagination'
    end
  end
end

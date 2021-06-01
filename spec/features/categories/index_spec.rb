# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can view list of categories', "
  In order to select needed category
  As an authenticated admin
  I'd like to be able to view list of categories
" do
  given(:admin) { create(:admin) }
  given!(:categories) { create_list(:test, 5) }
  given(:category) { categories.first }
  given!(:questions) { create_list(:question, 3, category: category) }

  background { sign_in(admin) }

  describe 'Admin views list of categories' do
    scenario 'can see list of categories' do
      visit admin_categories_path

      categories_on_page = page.all('.category').map(&:text)
      expect(categories_on_page).to match_array categories.map(&:name)
    end

    scenario 'can see question count for category' do
      visit admin_categories_path

      expect(page).to have_selector 'td', text: questions.size
    end
  end
end

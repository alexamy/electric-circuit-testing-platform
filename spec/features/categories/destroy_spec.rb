# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete category', "
  In order to git rid of old category
  As an authenticated admin
  I'd like to be able to delete category
" do
  given(:admin) { create(:admin) }
  given!(:categories) { create_list(:category, 5) }
  given(:category) { categories.first }

  background { sign_in(admin) }

  scenario 'Admin destroys category' do
    visit admin_categories_path

    within 'table' do
      click_on 'Удалить', match: :first

      expect(page).not_to have_content category.name
    end
  end
end

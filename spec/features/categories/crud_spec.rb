# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can view list of categories', "
  In order to control category resource
  As an authenticated admin
  I'd like to be able to perform crud operations on categories
" do
  given(:admin) { create(:admin) }
  given!(:categories) { create_list(:category, 5) }

  background { sign_in(admin) }

  scenario 'Admin views list of categories' do
    visit admin_categories_path

    expect(page.all('.category').map(&:text)).to match_array categories.map(&:name)
  end
end

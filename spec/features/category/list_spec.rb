# frozen_string_literal: true

require 'rails_helper'

feature 'User can view list of categories', "
  In order to select preferable category
  As an unauthenticated user
  I would like to select a category
" do
  given!(:categories) { create_list(:category, 3) }

  scenario 'Anonymous views list of categories' do
    visit categories_path

    categories.each do |category|
      expect(page).to have_link category.name
    end
  end
end

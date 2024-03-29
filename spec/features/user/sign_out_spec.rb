# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', "
  In order to leave a site
  As a authenticated user
  I'd like to sign out
" do

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do
    sign_in(user)

    visit root_path
    click_on 'Выйти'

    expect(page).to have_content 'Выход из системы выполнен.'
  end

  scenario 'Unregistered user tries to sign out' do
    visit root_path

    expect(page).to have_no_button 'Выйти'
  end
end

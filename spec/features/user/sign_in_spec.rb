# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign in
" do
  given(:user) { create(:user) }

  scenario 'Registered user tries to sign in' do
    visit root_path

    within '.new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
      click_on 'Войти'
    end

    expect(page).to have_content 'Вход в систему выполнен.'
  end

  scenario 'Unregistered user tries to sign in' do
    visit new_user_session_path

    within '.new_user' do
      fill_in 'Email', with: 'wrong@test.com'
      fill_in 'Пароль', with: '123456'
      click_on 'Войти'
    end

    expect(page).to have_content 'Неверный Email или пароль.'
  end
end

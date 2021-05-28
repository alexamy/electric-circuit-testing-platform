# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign up', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign up
" do

  given(:user) { create(:user) }
  given!(:group) { create(:group, name: 'Group', year: 2000) }

  describe 'Unauthenticated user' do
    scenario 'tries to sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: 'test@example.com'
      fill_in 'Пароль', with: '12345678'
      fill_in 'Подтверждение пароля', with: '12345678'

      fill_in 'Имя', with: 'Александр'
      fill_in 'Отчество', with: ''
      fill_in 'Фамилия', with: 'Александров'
      select 'Group (2000)', from: 'user_group_id'

      click_on 'Зарегистрироваться'

      expect(page).to have_content 'Вы успешно зарегистрировались.'
    end

    # didnt add test cases for incorrect email and short password
    # because it's handled by devise gem internally
    scenario 'tries to sign up with errors' do
      visit new_user_registration_path

      click_on 'Зарегистрироваться'

      expect(page).to have_content 'Email не может быть пустым'
      expect(page).to have_content 'Пароль не может быть пустым'
    end
  end

  scenario 'Authenticated user tries to sign up' do
    sign_in(user)

    visit new_user_registration_path

    expect(page).to have_content 'Вы уже вошли в систему.'
  end
end

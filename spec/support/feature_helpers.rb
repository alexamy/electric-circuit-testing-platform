# frozen_string_literal: true

module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path

    within '.new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
      click_on 'Войти'
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can create student', "
  In order to add new students
  As an authenticated admin
  I'd like to be able to create new students
" do
  given(:admin) { create(:admin) }
  given!(:group) { create(:group, name: 'Group', year: 2000) }

  background { sign_in(admin) }

  scenario 'Admin creates student' do
    visit new_admin_student_path

    fill_in 'Email', with: 'student@example.com'
    fill_in 'Пароль', with: 'testpassword'
    fill_in 'Имя', with: 'John'
    fill_in 'Фамилия', with: 'Doe'
    select 'Group (2000)', from: 'student_group_id'

    click_on 'Сохранить'

    expect(page).to have_content 'Студент успешно создан'
    expect(page).to have_content 'student@example.com'
  end
end

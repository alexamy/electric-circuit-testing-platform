# frozen_string_literal: true

require 'rails_helper'

feature 'Teacher can edit student', "
  In order to change student information
  As an authenticated teacher
  I'd like to be able to edit existing students
" do
  given(:teacher) { create(:teacher) }
  given(:group) { create(:group, name: 'Group', year: 2000) }
  given!(:student) { create(:student, group: group) }

  background { sign_in(teacher) }

  scenario 'Teacher creates student' do
    visit edit_teacher_student_path(student)

    fill_in 'Имя', with: 'Steve'
    click_on 'Сохранить'

    expect(page).to have_content 'Студент успешно сохранен'
    expect(page).to have_content 'Steve'
  end
end

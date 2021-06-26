# frozen_string_literal: true

require 'rails_helper'

feature 'User can see his name', "
  In order to know what he is logged
  As an authenticated user
  I'd like to be able to see my name in navbar
" do
  given(:teacher) { create(:teacher, email: 'jd.teacher@example.com') }
  given(:student) { create(:student, first_name: 'John', last_name: 'Doe') }

  scenario 'Student see his name' do
    sign_in(student)

    within '.navigation-bar' do
      expect(page).to have_content 'John Doe'
    end
  end

  scenario 'Teacher see his email' do
    sign_in(teacher)

    within '.navigation-bar' do
      expect(page).to have_content 'jd.teacher@example.com'
    end
  end
end

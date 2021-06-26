# frozen_string_literal: true

if Rails.env.development?
  Teacher.find_or_create_by!(email: 'teacher@test.com') do |user|
    user.password = 'testtest'
  end
end

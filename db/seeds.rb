# frozen_string_literal: true

if Rails.env.development?
  Admin.find_or_create_by!(email: 'admin@test.com') do |user|
    user.password = 'testtest'
  end
end

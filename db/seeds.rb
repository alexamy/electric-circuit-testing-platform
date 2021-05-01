# frozen_string_literal: true

# users
User.find_or_create_by!(email: 'user@test.com') do |user|
  user.password = 'user123'
end

if Rails.env.development?
  Admin.find_or_create_by!(email: 'admin@test.com') do |user|
    user.password = 'testtest'
  end
end

require Rails.root.join('db/seeds/questions/main')

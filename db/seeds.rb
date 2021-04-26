# frozen_string_literal: true

# users
User.find_or_create_by(email: 'user@test.com') do |user|
  user.password = 'user'
end

Admin.find_or_create_by(email: 'admin@test.com') do |user|
  user.password = Rails.env.ADMIN_PASSWORD
end

require Rails.root.join('db/seeds/questions/main')

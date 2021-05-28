# frozen_string_literal: true

# groups
group = Group.find_or_create_by!(name: 'Группа') do |g|
  g.year = Time.current.year
end

# users
Student.find_or_create_by!(email: 'student@test.com') do |student|
  student.password = 'testtest'
  student.first_name = 'Иван'
  student.middle_name = 'Иванович'
  student.last_name = 'Иванов'
  student.group = group
end

if Rails.env.development?
  Admin.find_or_create_by!(email: 'admin@test.com') do |user|
    user.password = 'testtest'
  end
end

require Rails.root.join('db/seeds/questions/main')

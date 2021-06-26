# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:student], class: 'Student' do
    email
    password { '123456' }
    password_confirmation { '123456' }
    first_name { 'John' }
    middle_name { '' }
    last_name { 'Doe' }
    group
  end

  factory :teacher do
    email
    password { '123456' }
    password_confirmation { '123456' }
  end
end

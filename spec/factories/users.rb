# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    group

    factory :admin, class: 'Admin'
    factory :student, class: 'Student'
  end
end
